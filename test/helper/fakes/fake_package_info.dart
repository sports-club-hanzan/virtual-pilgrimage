import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void initializeFakePackageInfo({
  String appName = '巡礼ウォーク',
  String packageName = 'com.virtualpilgrimage',
  String version = '1.0.0',
  String buildNumber = '1',
}) {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('plugins.flutter.io/package_info');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
    if (methodCall.method == 'getAll') {
      return <String, dynamic>{
        'appName': appName,
        'packageName': packageName,
        'version': version,
        'buildNumber': buildNumber,
      };
    }
    return null;
  });
}
