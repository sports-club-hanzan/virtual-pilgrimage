import 'package:flutter/material.dart';

@immutable
class DatabaseException implements Exception {
  const DatabaseException({
    this.message,
    this.cause,
  });

  final String? message;

  final Exception? cause;
}
