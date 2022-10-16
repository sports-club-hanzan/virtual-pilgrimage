import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/components/atoms/primary_button.dart';
import 'package:virtualpilgrimage/ui/components/atoms/secondary_button.dart';
import 'package:virtualpilgrimage/ui/components/gender_radio_buttons.dart';
import 'package:virtualpilgrimage/ui/components/my_app_bar.dart';
import 'package:virtualpilgrimage/ui/components/my_text_form_field.dart';
import 'package:virtualpilgrimage/ui/pages/registration/registration_presenter.dart';
import 'package:virtualpilgrimage/ui/pages/registration/registration_state.codegen.dart';
import 'package:virtualpilgrimage/ui/pages/sign_in/sign_in_presenter.dart';
import 'package:virtualpilgrimage/ui/style/color.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';

class RegistrationPage extends ConsumerWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: RegistrationPageBody(ref),
    );
  }
}

// TODO(s14t284): デザインを整える
class RegistrationPageBody extends StatelessWidget {
  const RegistrationPageBody(this.ref, {super.key});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(registrationPresenterProvider.notifier);
    final state = ref.watch(registrationPresenterProvider);

    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _nicknameFormSection(state, notifier),
              _birthdayForm(state, notifier, context),
              _genderSelectForm(state, notifier),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: PrimaryButton(
                        onPressed: () async {
                          await notifier.onPressedRegistration();
                        },
                        text: '登録',
                        textSize: FontSize.largeSize,
                        buttonSize: Size(MediaQuery.of(context).size.width / 5 * 3, 48),
                      ),
                    ),
                    SecondaryButton(
                      onPressed: () async {
                        await ref.read(signInPresenterProvider.notifier).logout();
                        ref.read(routerProvider).go(RouterPath.signIn);
                      },
                      text: 'ログイン画面へ戻る',
                      buttonSize: Size(MediaQuery.of(context).size.width / 5 * 3, 48),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _nicknameFormSection(RegistrationState state, RegistrationPresenter notifier) {
    return SizedBox(
      height: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _leading('ニックネーム', true),
          MyTextFormField(
            formModel: state.nickname,
            onChanged: notifier.onChangedNickname,
            decoration: const InputDecoration(
              hintText: '半角英数字6~16文字。 例) ohenro12',
              prefixIcon: Icon(Icons.account_circle),
            ),
            // 半角英数のみを入力させるため visiblePassword で数値と半角英字が出るキーボードを表示
            textInputType: TextInputType.visiblePassword,
            formatters: [LengthLimitingTextInputFormatter(16)],
          ),
        ],
      ),
    );
  }

  Widget _birthdayForm(
    RegistrationState state,
    RegistrationPresenter notifier,
    BuildContext context,
  ) {
    return SizedBox(
      height: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _leading('生年月日', true),
          MyTextFormField(
            formModel: state.birthday,
            onChanged: notifier.onChangedBirthday,
            decoration: const InputDecoration(
              hintText: '例) 19500131 ※1950/01/31生まれ',
              prefixIcon: Icon(Icons.edit_calendar_outlined),
            ),
            // 生年月日は数値だけ入力できれば良いので数字だけが出るキーボードを表示
            textInputType: TextInputType.number,
            formatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(8),
            ],
          ),
          // TextButton(
          //   onPressed: () => notifier.onPressedDate(context),
          //   child: Text(
          //     DateFormat('yyyy/MM/dd').format(state.birthDay),
          //     style: const TextStyle(color: Colors.black, fontSize: FontSize.largeSize),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _genderSelectForm(RegistrationState state, RegistrationPresenter notifier) {
    return SizedBox(
      height: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _leading('性別'),
          GenderRadioButtons(
            radioButtonModel: state.gender,
            onChanged: notifier.onChangedGender,
            groupValue: state.gender.selectedValue,
          ),
        ],
      ),
    );
  }

  Widget _leading(String leadingText, [bool isRequired = false]) => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
        child: SizedBox(
          height: 28,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 設定必須なものは「必須」マークを付与する
              if (isRequired)
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadiusDirectional.circular(8),
                    ),
                    child: const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(4, 2, 4, 2),
                      child: Text(
                        '必須',
                        style: TextStyle(
                          fontSize: FontSize.mediumSize,
                          fontWeight: FontWeight.bold,
                          color: ColorStyle.white,
                        ),
                      ),
                    ),
                  ),
                ),
              // leadingを表示
              Text(
                leadingText,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
}
