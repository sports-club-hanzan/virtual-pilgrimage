enum SignInExceptionStatus {
  credentialIsNull,
  credentialUserIsNull,
  emailOrPasswordIsNull,
  firebaseException,
  wrongPassword,
  unknownException,
  platformException,
}

class SignInException implements Exception {
  String cause;
  SignInExceptionStatus status;

  SignInException(this.cause, this.status);
}
