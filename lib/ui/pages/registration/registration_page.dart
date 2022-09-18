import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/components/gender_radio_buttons.dart';
import 'package:virtualpilgrimage/ui/components/my_text_form_field.dart';
import 'package:virtualpilgrimage/ui/pages/registration/registration_presenter.dart';
import 'package:virtualpilgrimage/ui/pages/sign_in/sign_in_presenter.dart';
import 'package:virtualpilgrimage/ui/style/color.dart';

class RegistrationPage extends ConsumerWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('巡礼ウォーク'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
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
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
              ),
              MyTextFormField(
                formModel: state.nickname,
                onChanged: notifier.onChangedNickname,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelStyle: TextStyle(
                    color: state.nickname.focusNode.hasFocus
                        ? Theme.of(context).primaryColor
                        : ColorStyle.text,
                    fontWeight: state.nickname.focusNode.hasFocus
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  hintText: 'ニックネーム',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: ColorStyle.white,
                      width: 2,
                    ),
                  ),
                  focusColor: Theme.of(context).primaryColor,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.account_circle,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
              ),
              const Text('性別'),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
              ),
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
                  style: const TextStyle(color: Colors.black, fontSize: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                top: 32,
                right: 12,
                left: 12,
                bottom: 12,
              ),
                child: Column(),
              ),
              ElevatedButton(
                onPressed: () async {
                  await notifier.onPressedRegistration();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: const Text('登録'),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await ref.read(signInPresenterProvider.notifier).logout();
                  ref.read(routerProvider).go(RouterPath.signIn);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: const Text('ログイン画面'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
