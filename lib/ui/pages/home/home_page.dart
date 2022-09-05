import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/pages/sign_in/sign_in_presenter.dart';
import 'package:virtualpilgrimage/ui/style/color.dart';

// TODO: 仮でユーザの情報を表示しているだけ
class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        // TODO: タイトルは変更
        title: const Text('virtual pilgrimage'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: HomePageBody(ref),
    );
  }
}

class HomePageBody extends StatelessWidget {
  final WidgetRef _ref;

  const HomePageBody(this._ref, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userState = _ref.watch(userStateProvider);

    return Container(
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: Column(
            children: [
              const Text(
                'ホームページ',
                style: TextStyle(
                  fontSize: 64,
                  color: ColorStyle.primary,
                ),
              ),
              Column(
                children: [
                  Text(
                    'nickname: ${userState!.nickname}',
                    style: const TextStyle(
                      fontSize: 24,
                      color: ColorStyle.grey,
                    ),
                  ),
                  Text(
                    'email: ${userState.email}',
                    style: const TextStyle(
                      fontSize: 24,
                      color: ColorStyle.grey,
                    ),
                  ),
                  Text(
                    'gender: ${userState.gender}',
                    style: const TextStyle(
                      fontSize: 24,
                      color: ColorStyle.grey,
                    ),
                  ),
                  Text(
                    'birthday: ${DateFormat('yyyy/MM/dd').format(userState.birthDay)}',
                    style: const TextStyle(
                      fontSize: 24,
                      color: ColorStyle.grey,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  await _ref.read(signInPresenterProvider.notifier).logout();
                  _ref.read(routerProvider).go(RouterPath.signIn);
                },
                child: const Text('サインイン画面に戻る'),
              )
            ],
          ),
        ));
  }
}
