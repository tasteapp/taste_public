import 'dart:async';
import 'dart:convert';
import 'dart:js';
import 'dart:typed_data';

import 'package:node_http/node_http.dart';
import 'package:node_interop/child_process.dart';
import 'package:node_io/node_io.dart';
import 'package:pedantic/pedantic.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:test/test.dart' as testing;
import 'package:test/test.dart';

export 'package:node_interop/node.dart' hide Timeout;
export 'package:node_interop/util.dart';
export 'package:stack_trace/stack_trace.dart';
export 'package:taste_cloud_functions/taste_functions.dart';
export 'package:test/test.dart' hide test, Tags;

export 'fixture.dart';
export 'toolbox/toolbox.dart';

void test(String name, FutureOr Function() fn, {Timeout timeout}) =>
    Chain.capture(() => testing.test(name, fn, timeout: timeout));

ChildProcess process;

Future stopProcess() async {
  while (!(process?.killed ?? true)) {
    process?.kill('SIGINT');
    await sleep(0.25);
  }
}

Future restartProcess() async {
  await stopProcess();
  final log = File('./em-logs.txt').openWrite(mode: FileMode.write);
  final completer = Completer();
  final logClose = Completer();
  process = childProcess.spawn(
      'firebase',
      '-P FIREBASE_DEV_PROJECT emulators:start --only functions,firestore'
          .split(' '));
  void close() {
    logClose.complete();
    log.close();
  }

  void printer(d) {
    final string = String.fromCharCodes(d as Uint8List).trim();
    if (string.contains('Shutting down emulators')) {
      close();
      return;
    }
    if (string.contains('All emulators ready!')) {
      if (!completer.isCompleted) {
        completer.complete(true);
        return;
      }
    }
    if (completer.isCompleted) {
      log.writeln(string);
    }
  }

  final errd = process.stderr.on('data', allowInterop(printer));
  final outd = process.stdout.on('data', allowInterop(printer));
  final oute = process.stdout.on('exit', allowInterop((_) => log.close()));
  unawaited(logClose.future.then((value) {
    errd.removeAllListeners('data');
    outd.removeAllListeners('data');
    oute.removeAllListeners('exit');
  }));

  return await completer.future;
}

Future setupEmulator() async {
  assert(buildType == BuildType.test);
  CloudTransformProvider.initialize();
  await restartProcess();
}

Future tearDownEmulator() async {
  await stopProcess();
}

extension Trans on String {
  DocumentSnapshot get snapshot => SimpleSnapshot(DocumentData(), ref);
}

Future<bool> waitFor(Future<bool> Function() condition,
    [Duration duration = const Duration(seconds: 30)]) async {
  final now = DateTime.now();
  Future<bool> run() async {
    if (await condition()) {
      return true;
    }
    final remaining = duration - DateTime.now().difference(now);
    if (remaining > const Duration()) {
      print('${remaining.inSeconds} seconds remaining...');
      await Future.delayed(const Duration(seconds: 1));
      return await run();
    }
    return false;
  }

  return await run();
}

Future<bool> waitForEquals<T>(T expected, Future<T> Function() actualFn,
    {Duration duration = const Duration(seconds: 30),
    bool notEquals = false,
    bool earlyExit = true}) async {
  final stop = DateTime.now().add(duration);
  var becameTrue = false;
  Future<bool> run() async {
    final actual = await actualFn();
    final condition = notEquals ? (actual != expected) : (actual == expected);
    final remaining = stop.difference(DateTime.now());
    if (remaining.inMilliseconds < 0 || (condition && earlyExit)) {
      return condition;
    }
    if (becameTrue && !condition) {
      print('became untrue');
      return condition;
    }
    becameTrue = condition;
    print('${remaining.inSeconds}s $expected ${notEquals ? '!' : '='} $actual');
    await Future.delayed(const Duration(seconds: 1));
    return await run();
  }

  return await run();
}

Future<DocumentSnapshot> first(DocumentQuery query,
    [Duration duration = const Duration(seconds: 30)]) async {
  final now = DateTime.now();
  final completer = Completer<DocumentSnapshot>();
  Timer.periodic(const Duration(seconds: 1), (t) async {
    final result = await query.get();
    if (result.isNotEmpty) {
      completer.complete(result.documents.first);
      t.cancel();
      return;
    }
    if (result.isEmpty) {
      final remaining = duration - DateTime.now().difference(now);
      print('${remaining.inSeconds} seconds remaining...');
      if (remaining < const Duration()) {
        completer.complete(null);
        t.cancel();
        return;
      }
    }
  });
  return completer.future;
}

class FakeIdToken implements DecodedIdToken {
  @override
  String get aud => null;

  @override
  // ignore: non_constant_identifier_names
  num get auth_time => 0;

  @override
  num get exp => 0;

  @override
  FirebaseSignInInfo get firebase => null;

  @override
  num get iat => 0;

  @override
  String get iss => null;

  @override
  String get sub => null;

  @override
  String get uid => null;
}

class FakeCallableContext extends CallableContext {
  FakeCallableContext(String eventId) : super('', FakeIdToken(), '', eventId);
}

class FakeTransactionContext extends TransactionContext {
  FakeTransactionContext(Map<String, dynamic> requestData, TasteUser user)
      : super(FakeCallableContext('event-id'), requestData, quickTrans,
            user.ref.documentID);
}

Future<Status> tasteFn(String name, Map payload, TasteUser user) async {
  assert(user != null);
  final userId = user.ref.documentID;
  payload['__test_user__'] = userId;
  final response = await post(
      'http://localhost:5001/FIREBASE_DEV_PROJECT/us-central1/tasteCall',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'data': {'fn': name, 'payload': payload}
      }));
  final json = jsonDecode(response.body)['result'];
  if (json['success'] as bool ?? false) {
    return Status.value(json['value']);
  }
  print(['Taste Call failed', name, payload, userId, json]);
  return Status.fail(json['reason'] as String);
}

testing.Matcher containsExactly(Iterable expected) => testing.allOf(
    testing.containsAll(expected), testing.hasLength(expected.length));

extension St on Status {
  Future<DocumentSnapshot> get snapshot async =>
      await (value['reference'] as String).ref.get();
}

Future sleep(double seconds) =>
    Future.delayed(Duration(milliseconds: (seconds * 1000).toInt()));

Future eventually<T>(FutureOr<T> Function() condition, dynamic matcher,
    {Duration duration = const Duration(seconds: 50),
    dynamic Function(T t) message}) async {
  final now = DateTime.now();
  Future run() async {
    final t = await condition();
    print(message == null ? '$t should be $matcher' : message(t));
    try {
      testing.expect(t, matcher);
    } catch (c) {
      final remaining = duration - DateTime.now().difference(now);
      if (remaining <= const Duration()) {
        rethrow;
      }
      print('${remaining.inSeconds} seconds remaining...');
      await Future.delayed(const Duration(seconds: 1));
      return await run();
    }
  }

  await run();
}

extension DateChangeExtension on SnapshotHolder {
  Future changeDate(DateTime date) =>
      updateSelf({'_extras.created_at': date.timestamp});
}

dynamic near(num target) => inInclusiveRange(target - 1e-3, target);

Future countdown(int seconds) => (() async* {
      for (var i = 0; i < seconds; i++) {
        print(seconds - i);
        yield seconds - i;
        await sleep(1);
      }
      print(0);
    })()
        .toList();
