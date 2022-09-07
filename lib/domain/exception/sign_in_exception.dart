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
  SignInException(this.cause, this.status);

  String cause;
  SignInExceptionStatus status;
}
