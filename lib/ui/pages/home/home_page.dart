import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/components/my_app_bar.dart';
import 'package:virtualpilgrimage/ui/pages/home/components/google_map_view.dart';
import 'package:virtualpilgrimage/ui/pages/sign_in/sign_in_presenter.dart';
import 'package:virtualpilgrimage/ui/style/color.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: HomePageBody(ref),
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody(this._ref, {super.key});

  final WidgetRef _ref;

  @override
  Widget build(BuildContext context) {
    final userState = _ref.watch(userStateProvider);

    return ColoredBox(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: ListView(
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
                  'nickname: ${userState?.nickname ?? ''}',
                  style: const TextStyle(
                    fontSize: 24,
                    color: ColorStyle.grey,
                  ),
                ),
                Text(
                  'email: ${userState?.email ?? ''}',
                  style: const TextStyle(
                    fontSize: 24,
                    color: ColorStyle.grey,
                  ),
                ),
                Text(
                  'gender: ${userState?.gender ?? ''}',
                  style: const TextStyle(
                    fontSize: 24,
                    color: ColorStyle.grey,
                  ),
                ),
                Text(
                  'birthday: ${userState != null ? DateFormat('yyyy/MM/dd').format(userState.birthDay) : ''}',
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
            ),
            const Padding(
              padding: EdgeInsetsDirectional.all(16),
            ),
            GoogleMapView(_ref),
          ],
        ),
      ),
    );
  }
}
