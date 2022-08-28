import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/model/form_model.codegen.dart';
import 'package:virtualpilgrimage/ui/pages/registration/registration_state.codegen.dart';

final registrationPresenterProvider =
    StateNotifierProvider.autoDispose<RegistrationPresenter, RegistrationState>(
  (ref) => RegistrationPresenter(ref, ref.watch(userStateProvider)),
);

class RegistrationPresenter extends StateNotifier<RegistrationState> {
  final Ref _ref;

  RegistrationPresenter(this._ref, VirtualPilgrimageUser? user)
      : super(RegistrationState(
          // FIXME: nickname validator を入れる。文字数制限やアルファベットで記載する程度のvalidation
          nickname:
              FormModel.of((value) => null, user != null ? user.nickname : ''),
          gender: user != null ? user.gender : Gender.unknown,
          birthDay: user != null ? user.birthDay : DateTime.utc(1980),
        ));

  void initialize(String nickname, Gender gender, DateTime birthday) {
    state = RegistrationState(
        // FIXME: nickname validator を入れる。文字数制限やアルファベットで記載する程度のvalidation
        nickname: FormModel.of((value) => null, nickname),
        gender: gender,
        birthDay: birthday);
  }

  void onChangedNickname(FormModel nickname) =>
      state = state.copyWith(nickname: nickname);
}
