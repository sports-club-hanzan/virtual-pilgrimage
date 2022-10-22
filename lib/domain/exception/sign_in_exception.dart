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
  userNotFoundException,
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
  String toString() =>
      'SignInException: [message][$message][status][$status][cause][${cause?.toString()}]';
}
