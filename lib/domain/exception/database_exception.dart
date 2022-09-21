import 'package:flutter/material.dart';

@immutable
class DatabaseException implements Exception {
  const DatabaseException({
    required this.message,
    this.cause,
  });

  final String message;

  final Exception? cause;

  @override
  String toString() => 'GetHealthException: [message][$message][cause][${cause.toString()}]';
}
