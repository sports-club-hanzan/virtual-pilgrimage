import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/components/gender_radio_buttons.dart';
import 'package:virtualpilgrimage/ui/components/my_text_form_field.dart';
import 'package:virtualpilgrimage/ui/pages/registration/registration_presenter.dart';
import 'package:virtualpilgrimage/ui/pages/sign_in/sign_in_presenter.dart';
import 'package:virtualpilgrimage/ui/style/color.dart';

class RegistrationPage extends ConsumerWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        // TODO: タイトルは変更
        title: const Text('virtual pilgrimage'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: RegistrationPageBody(ref),
    );
  }
}

// TODO: ユーザ情報を編集するフォームに修正
class RegistrationPageBody extends StatelessWidget {
  final WidgetRef ref;

  const RegistrationPageBody(this.ref, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(registrationPresenterProvider.notifier);
    final state = ref.watch(registrationPresenterProvider);

    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 32.0,
                right: 12.0,
                left: 12.0,
                bottom: 12.0,
              ),
              child: Column(
                children: [
                  MyTextFormField(
                    formModel: state.nickname,
                    onChanged: notifier.onChangedNickname,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'ニックネーム',
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
                          width: 2.0,
                        ),
                      ),
                      focusColor: Theme.of(context).primaryColor,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2.0,
                        ),
                      ),
                      prefixIcon: Icon(Icons.account_circle,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            GenderRadioButtons(
              radioButtonModel: state.gender,
              onChanged: notifier.onChangedGender,
              groupValue: state.gender.selectedValue,
            ),
            Column(
              children: [
                const Text('生年月日'),
                TextButton(
                    onPressed: () => notifier.onPressedDate(context),
                    child: Text(DateFormat('yyyy/MM/dd').format(state.birthDay),
                        style: const TextStyle(color: Colors.black))),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await notifier.onPressedRegistration();
                // TODO: ホームページに遷移
                print(result);
                print(ref.read(userStateProvider));
              },
              child: const Text('ユーザ情報登録'),
            ),
            ElevatedButton(
              onPressed: () async {
                await ref.read(signInPresenterProvider.notifier).logout();
                ref.read(routerProvider).go(RouterPath.signIn);
              },
              child: const Text('サインイン画面に戻る'),
            )
          ],
        ),
      ),
    );
  }
}
