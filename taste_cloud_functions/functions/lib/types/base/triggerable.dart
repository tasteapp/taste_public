import 'package:node_io/node_io.dart';
import 'package:source_map_stack_trace/source_map_stack_trace.dart';
import 'package:source_maps/source_maps.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:taste_cloud_functions/taste_functions.dart';

typedef FirestoreConstructor<T extends FirestoreProto> = T Function(
    DocumentSnapshot snapshot,
    BatchedTransaction transaction,
    bool checkExists);
typedef Triggerable<T extends FirestoreProto> = Function(
  CollectionType type,
  FirestoreConstructor<T> constructor,
);

Triggerable<T> trigger<T extends FirestoreProto>(
    {Object Function(T t) delete,
    Object Function(T after, Change<T> before) update,
    Object Function(T) create,
    Set<String> requiredChangedFields = const {}}) {
  void helper(CollectionType type, FirestoreConstructor<T> constructor) {
    final path = '${type.name}/{wildcard}';
    if (delete != null) {
      final triggerType = 'delete';
      final triggerName = 'trigger_${triggerType}_${type.name}';
      tasteFunctions[triggerName] = tasteFunctions.firestore
          .document(path)
          .onDelete((data, context) async {
        final log = structuredLog(
          triggerName,
          context.eventId,
          'trigger',
          {
            'reference': data.reference.path,
            'trigger-type': triggerType,
          },
        );
        await _call(
            context.eventId, (t) async => delete(constructor(data, t, false)));
        return log;
      });
    }
    if (create != null) {
      final triggerType = 'create';
      final triggerName = 'trigger_${triggerType}_${type.name}';
      tasteFunctions[triggerName] = tasteFunctions.firestore
          .document(path)
          .onCreate((data, context) async {
        final log = structuredLog(
          triggerName,
          context.eventId,
          'trigger',
          {
            'reference': data.reference.path,
            'trigger-type': triggerType,
          },
        );
        await Chain.capture(
            () => _call(context.eventId,
                (t) async => create(constructor(data, t, true))),
            onError: (a, b) {
          print(Chain.forTrace(mapStackTrace(
                  parseJson(Map.from(jsonDecode(File(
                          '/Users/jdrblu/taste/taste_cloud_functions/export/index.dart.js.map')
                      .readAsStringSync()) as Map)),
                  b.toTrace()))
              .terse);
        });
        await log;
      });
    }
    if (update != null) {
      final triggerType = 'update';
      final triggerName = 'trigger_${triggerType}_${type.name}';
      tasteFunctions[triggerName] = tasteFunctions.firestore
          .document(path)
          .onUpdate((data, context) async {
        final log = structuredLog(
          triggerName,
          context.eventId,
          'trigger',
          {
            'reference': data.before.reference.path,
            'trigger-type': triggerType,
          },
        );
        if (requiredChangedFields.isNotEmpty &&
            !data.fieldsChanged(requiredChangedFields)) {
          await structuredLog(
            triggerName,
            context.eventId,
            'trigger',
            {
              'reference': data.before.reference.path,
              'trigger-type': 'update',
              'skipped': true,
            },
          );
          return log;
        }
        await _call(context.eventId, (t) async {
          final after = constructor(data.after, t, true);
          final before = constructor(data.before, t, true);
          return update(after, Change(after, before));
        });
        return log;
      });
    }
  }

  return helper;
}

Future _call(String eventId, Future Function(BatchedTransaction t) fn) {
  return autoBatch((t) async {
    try {
      final result = await fn(t);
      if (result is Iterable<Future>) {
        await result.wait;
      }
    } on CloudFnException catch (e, s) {
      print('cloud fn error ${e.message}\n\n$s');
    } on MissingReference catch (e, s) {
      print('missing-ref ${e.reference} ${buildType.isTest ? '' : s}');
    } catch (e, s) {
      print('Unexpected error $e\n\n$s');
    }
  }, eventId: eventId);
}
