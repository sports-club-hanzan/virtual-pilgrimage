import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/components/atoms/primary_button.dart';
import 'package:virtualpilgrimage/ui/components/atoms/secondary_button.dart';
import 'package:virtualpilgrimage/ui/components/gender_radio_buttons.dart';
import 'package:virtualpilgrimage/ui/components/my_app_bar.dart';
import 'package:virtualpilgrimage/ui/components/my_text_form_field.dart';
import 'package:virtualpilgrimage/ui/pages/registration/registration_presenter.dart';
import 'package:virtualpilgrimage/ui/pages/sign_in/sign_in_presenter.dart';
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
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('ニックネーム'),
              const Padding(padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10)),
              MyTextFormField(
                formModel: state.nickname,
                onChanged: notifier.onChangedNickname,
                decoration: const InputDecoration(
                  hintText: 'ニックネーム',
                  prefixIcon: Icon(Icons.account_circle),
                ),
              ),
              const Padding(padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10)),
              const Text('性別'),
              const Padding(padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10)),
              GenderRadioButtons(
                radioButtonModel: state.gender,
                onChanged: notifier.onChangedGender,
                groupValue: state.gender.selectedValue,
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
              ),
              const Text('生年月日'),
              TextButton(
                onPressed: () => notifier.onPressedDate(context),
                child: Text(
                  DateFormat('yyyy/MM/dd').format(state.birthDay),
                  style: const TextStyle(color: Colors.black, fontSize: FontSize.largeSize),
                ),
              ),
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
}
