enum SignInExceptionStatus {
  credentialIsNull,
  credentialUserIsNull,
  emailOrPasswordIsNull,
  firebaseException,
  unknownException,
}

class SignInException implements Exception {
  String cause;
  SignInExceptionStatus status;

  SignInException(this.cause, this.status);
}
