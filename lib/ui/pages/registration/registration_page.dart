import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/pages/sign_in/sign_in_presenter.dart';

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
    final user = ref.read(userStateProvider)!;
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          Row(
            children: [
              const Text('id: '),
              Text(user.id),
            ],
          ),
          Row(
            children: [
              const Text('email: '),
              Text(user.email),
            ],
          ),
          Row(
            children: [
              const Text('nickname: '),
              Text(user.nickname),
            ],
          ),
          Row(
            children: [
              const Text('birthday: '),
              Text(user.birthDay.toIso8601String()),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              await ref.read(signInControllerProvider.notifier).logout();
              ref.read(routerProvider).go(RouterPath.signIn);
            },
            child: const Text('サインイン画面に戻る'),
          )
        ],
      ),
    );
  }
}
