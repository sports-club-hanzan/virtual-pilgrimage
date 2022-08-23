import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart' as lib;

class Logger {
  final lib.Logger _logger = lib.Logger(
    printer: lib.PrettyPrinter(
      methodCount: 1, // 表示されるコールスタックの数
      errorMethodCount: 5, // 表示されるスタックトレースのコールスタックの数
      lineLength: 120, // 出力するログ1行の幅
      colors: true, // メッセージに色をつけるかどうか
      printEmojis: true, // 絵文字を出力するかどうか
      printTime: true, // タイムスタンプを出力するかどうか
    ),
  );

  final FirebaseCrashlytics _crashlytics;

  final String _className;

  Logger(this._crashlytics, this._className);

  debug(dynamic message) {
    _logger.d(message);
  }

  info(dynamic message) {
    _logger.i(message);
    _crashlytics.log('[_className][$_className] $message');
  }

  warn(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, [error, stackTrace]);
    _crashlytics.log('[_className][$_className] $message');
    _crashlytics.recordError(error, stackTrace);
  }

  error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, [error, stackTrace]);
    _crashlytics.log('[_className][$_className] $message');
    _crashlytics.recordError(error, stackTrace);
  }
}

final logger = lib.Logger(
  printer: lib.PrettyPrinter(
    methodCount: 1, // 表示されるコールスタックの数
    errorMethodCount: 5, // 表示されるスタックトレースのコールスタックの数
    lineLength: 120, // 出力するログ1行の幅
    colors: true, // メッセージに色をつけるかどうか
    printEmojis: true, // 絵文字を出力するかどうか
    printTime: true, // タイムスタンプを出力するかどうか
  ),
);
