import 'package:googleapis_auth/auth_io.dart';
import 'package:node_http/node_http.dart';
import 'package:taste_cloud_functions/taste_functions.dart';

final credentialsMap = buildTypeCredentialsMap() ?? {};
final projectId = credentialsMap['project_id'] ?? 'fake-project-id';
final storageBucket = '$projectId.appspot.com';
final admin = FirebaseAdmin.instance.initializeApp(ifNotTest(() => AppOptions(
    storageBucket: storageBucket,
    credential: FirebaseAdmin.instance.cert(
        privateKey: credentialsMap['private_key'],
        projectId: credentialsMap['project_id'],
        clientEmail: credentialsMap['client_email']))));

final Algolia algolia = environments[buildType].init;

const region = 'us-central1';

final tasteFunctions = functions
    .region(region)
    .runWith(RuntimeOptions(timeoutSeconds: 540, memory: '2GB'));

final StackdriverLog _log = StackdriverLog.named(
    'cloud_functions', {'credentials': buildTypeCredentialsMap()});

Future structuredLog(
    Object tasteFn, String executionId, String tag, dynamic payload,
    [Map<String, dynamic> metadata]) async {
  executionId ??= 'noexecutionid';
  final name = tasteFnName(tasteFn) ?? tasteFn.toString();
  if (buildType.isTest) {
    print('LOG $name $executionId $tag $payload');
    return;
  }
  try {
    await _log.log(name, executionId, region, {
      'taste-tag': tag,
      'execution-id-taste': executionId,
      'payload': payload,
      'metadata': metadata ?? <String, String>{},
    });
  } catch (e) {
    print('Error logging! $e');
  }
}

final firestore = admin.firestore();
final firebaseAuth = admin.auth();
final messaging = admin.messaging();

final authenticatedHttpClient = buildType.isTest
    ? null
    : clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(credentialsMap),
        ['https://www.googleapis.com/auth/cloud-platform'],
        baseClient: NodeClient());

// clientViaApiKey('AIzaSyBOli2JYtAR5SfGBU98c36WQ2rpEXGCI_I',
//         baseClient: NodeClient());
