enum SignInExceptionStatus {
  credentialIsNull,
  credentialUserIsNull,
  emailOrPasswordIsNull,
  firebaseException,
  weakPassword,
  alreadyUsedEmail,
  wrongPassword,
  unknownException,
  platformException,
}

class SignInException implements Exception {
  SignInException({
    required this.message,
    required this.status,
    this.cause,
  });

  final String message;
  final SignInExceptionStatus status;
  final Exception? cause;

  @override
  String toString() => 'SignInException: [cause][$message][status][$status]';
}
