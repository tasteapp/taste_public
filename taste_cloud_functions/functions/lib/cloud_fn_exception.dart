/// An error with a `message` which is safe to return to the client. We should
/// always be careful about the information stored in `message`, as it must not
/// leak any sensitive data, while still providing useful feedback on errors to
/// the client.
class CloudFnException implements Exception {
  final String message;

  CloudFnException(this.message);

  @override
  String toString() {
    return 'CFE: $message';
  }
}
