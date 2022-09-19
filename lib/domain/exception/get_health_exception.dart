enum HealthExceptionStatus {
  notAuthorized,
  unknown
}

class GetHealthException implements Exception {
  GetHealthException(this.cause, this.status);

  String cause;
  HealthExceptionStatus status;
}
