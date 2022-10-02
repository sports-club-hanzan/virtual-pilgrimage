import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.codegen.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  factory ProfileState({
    required int selectedTabIndex,
  }) = _ProfileState;

  const ProfileState._();
}
