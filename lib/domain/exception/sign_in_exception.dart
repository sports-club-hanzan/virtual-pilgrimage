enum SignInExceptionStatus {
  credentialIsNull,
  credentialUserIsNull,
  emailOrPasswordIsNull,
  firebaseException,
  unknownException,
  platformException,
}

class SignInException implements Exception {
  String cause;
  SignInExceptionStatus status;

  SignInException(this.cause, this.status);
}
