import 'dart:core';

// Testable な DateTime
// DateTime.now() のテスト時に固定した時刻を返せるようにするために利用
// プロダクションコードでは CustomizableDateTime.current を呼び出す
// テスト時には CustomizableDateTime.customTime = DateTime(...) を呼び出し時刻を固定
// ref. https://stackoverflow.com/questions/53674027/is-there-a-way-to-fake-datetime-now-in-a-flutter-test/63073876#63073876
extension CustomizableDateTime on DateTime {
  static DateTime? _customTime;

  static DateTime get current {
    return _customTime ?? DateTime.now();
  }

  static set customTime(DateTime customTime) {
    _customTime = customTime;
  }
}
