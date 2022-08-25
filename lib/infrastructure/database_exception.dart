import 'package:flutter/material.dart';

@immutable
class DatabaseException implements Exception {
  final String? message;

  final Exception? cause;

  const DatabaseException({
    this.message,
    this.cause,
  });
}
