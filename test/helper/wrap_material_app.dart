import 'package:flutter/material.dart';

// MaterialApp, Scaffold で widget を括って返す
/// ページ単位でないコンポーネントのテストに利用
Widget wrapMaterialApp(Widget widget) {
  return MaterialApp(
    home: Scaffold(
      body: widget,
    ),
  );
}
