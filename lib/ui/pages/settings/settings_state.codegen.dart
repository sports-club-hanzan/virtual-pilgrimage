import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.codegen.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  // 設定項目があれば factory に追加し、デフォルト値を保存している情報から詰める
  const factory SettingsState() = _SettinsState;

  const SettingsState._();
}
