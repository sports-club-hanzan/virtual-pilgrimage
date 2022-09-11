import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    // 表示されるコールスタックの数
    errorMethodCount: 5,
    // 表示されるスタックトレースのコールスタックの数
    lineLength: 120,
    // 出力するログ1行の幅
    colors: true,
    // メッセージに色をつけるかどうか
    printEmojis: true,
    // 絵文字を出力するかどうか
    printTime: true, // タイムスタンプを出力するかどうか
  ),
);

final loggerProvider = Provider<Logger>(
  (_) => _logger,
);
