import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart';

// TODO(team): Deprecated, remove soon.
final TransactionFn generateAuthToken = (context) async {
  final request = context.data.asProto(GenerateAuthTokenRequest());
  if (request.uid.isEmpty) {
    throw CloudFnException('Empty UID');
  }
  return await firebaseAuth.createCustomToken(
      (await firebaseAuth.getUser(request.uid).catchError((e) => null) ??
              await firebaseAuth.createUser(
                // You CANNOT just pass null or empty for email, will fail.
                request.email.isNotEmpty
                    ? CreateUserRequest(
                        uid: request.uid,
                        displayName: request.fullName,
                        email: request.email,
                      )
                    : CreateUserRequest(
                        uid: request.uid,
                        displayName: request.fullName,
                      ),
              ))
          .uid,
      {});
};

void register() {
  registerCallFn(generateAuthToken, 'generateAuthToken');
}
