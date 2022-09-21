enum GetHealthExceptionStatus { notAuthorized, unknown }

class GetHealthException implements Exception {
  GetHealthException(this.cause, this.status);

  String cause;
  GetHealthExceptionStatus status;
}
