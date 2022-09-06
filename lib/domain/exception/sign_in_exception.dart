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
  SignInException(this.cause, this.status);

  String cause;
  SignInExceptionStatus status;
}
