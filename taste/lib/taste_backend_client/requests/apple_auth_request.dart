import 'package:meta/meta.dart';

class AppleAuthRequest {
  const AppleAuthRequest({@required this.uid, this.fullName, this.email});
  final String uid;
  final String fullName;
  final String email;

  Map<String, dynamic> get input => {
        'uid': uid,
        'full_name': fullName,
        'email': email,
      };
}
