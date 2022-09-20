import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtualpilgrimage/main.dart';
import 'package:workmanager/workmanager.dart';

// アプリケーションの初期化時に呼ばれるルートメソッド
// ref. https://github.com/fluttercommunity/flutter_workmanager
// callbackDispatcher はドキュメント通りに static method にしても動作しなかったため、toplevel function として定義
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
    await Firebase.initializeApp(options: getFirebaseOptions(flavor));
    final prefs = await SharedPreferences.getInstance();
    print('=============');
    print(taskName);
    print(inputData);
    print('=============');
    switch (taskName) {
      case BackgroundTaskName.recordStepAndDistance:
        print('--- show Shared Pref value ---');
        print(prefs.getString(taskName));
        final userId = prefs.getString(SharedPreferencesFieldName.userId);
        if (userId != null) {}
        break;
    }
    return Future.value(true);
  });
}

extension BackgroundTaskName on String {
  static const recordStepAndDistance = 'recordStepAndDistance';
}

extension SharedPreferencesFieldName on String {
  static const userId = 'userId';
}

// workmanager によるバックグラウンド処理の定義を行うサービス
class BackgroundTaskService {
  // Android では15分間隔が最速の間隔となっているためデフォルト値とする
  static const defaultFrequency = Duration(minutes: 15);

  static void callbackDispatcher() {
    Workmanager().executeTask((taskName, inputData) async {
      final prefs = await SharedPreferences.getInstance();
      print('=============');
      print(taskName);
      print(inputData);
      print('=============');
      switch (taskName) {
        case BackgroundTaskName.recordStepAndDistance:
          print('--- show Shared Pref value ---');
          print(await prefs.getString(taskName));
          break;
      }
      return Future.value(true);
    });
  }

  /// 歩数と距離をDBに保存するバックグラウンド処理の定義
  static Future<void> registRecordStepAndDistance({Duration frequency = defaultFrequency}) =>
      Workmanager().registerPeriodicTask(
        'periodicRecordStepAndDistance',
        BackgroundTaskName.recordStepAndDistance,
        inputData: {'aaa': 'bbb'},
        frequency: frequency,
        initialDelay: const Duration(seconds: 20),
      );
}
