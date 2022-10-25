import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/temple/temple_repository.dart';
import 'package:virtualpilgrimage/domain/user/pilgrimage/pilgrimage_repository.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/components/bottom_navigation.dart';
import 'package:virtualpilgrimage/ui/components/my_app_bar.dart';
import 'package:virtualpilgrimage/ui/pages/home/components/google_map_view.dart';
import 'package:virtualpilgrimage/ui/pages/sign_in/sign_in_presenter.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: HomePageBody(ref),
      bottomNavigationBar: const BottomNavigation(),
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
            const GoogleMapView(),
            // TODO(s14t284): 開発用に残しているだけなので削除予定
            if (kDebugMode)
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _ref.read(signInPresenterProvider.notifier).logout();
                      _ref.read(routerProvider).go(RouterPath.signIn);
                    },
                    child: const Text('サインイン画面に戻る'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final pilgrimage = _ref.watch(pilgrimageRepositoryProvider);
                      final url = await pilgrimage.getTempleImageUrl(
                        userState?.pilgrimage.nowPilgrimageId.toString() ?? '1',
                        '1.jpg',
                      );
                      final temple = _ref.watch(templeRepositoryProvider);
                      final templeInfo = await temple.getTempleInfo(1);
                      await showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(templeInfo.prefecture),
                            content: Image.network(url),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('閉じる'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('お寺の情報を表示する'),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
