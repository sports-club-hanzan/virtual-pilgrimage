enum GetHealthExceptionStatus { notAuthorized, unknown }

class GetHealthException implements Exception {
  GetHealthException({
    required this.message,
    required this.status,
    this.cause,
  });

  final String message;
  final GetHealthExceptionStatus status;
  final Exception? cause;

  @override
  String toString() => 'GetHealthException: [message][$message][status][$status]';
}
