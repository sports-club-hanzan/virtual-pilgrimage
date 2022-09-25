import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/pages/home/home_presenter.dart';
import 'package:virtualpilgrimage/ui/pages/sign_in/sign_in_presenter.dart';
import 'package:virtualpilgrimage/ui/style/color.dart';

// TODO(s14t284): 仮でユーザの情報を表示しているだけ
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('巡礼ウォーク'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
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
    final state = _ref.watch(homeProvider);
    // FIXME: unused な変数じゃなくなったらコメントを削除
    // MEMO: 現在はunusedな変数だが、ここで呼び出すことで初期化処理が走り、歩数の記録を行う
    // ignore: unused_local_variable
    final notifier = _ref.read(homeProvider.notifier);
    // ignore: unused_local_variable
    late GoogleMapController mapController;
    const initialCameraPosition = CameraPosition(
      target: LatLng(34.1597388, 134.4675072),
      zoom: 10,
    );
    final markers = {
      const Marker(
        markerId: MarkerId('霊山寺'),
        position: LatLng(34.15944444, 134.503),
        infoWindow: InfoWindow(title: '霊峰寺', snippet: '1箇所目'),
      ),
      const Marker(
        markerId: MarkerId('極楽寺'),
        position: LatLng(34.15565, 134.490347),
        infoWindow: InfoWindow(title: '極楽寺', snippet: '2箇所目'),
      ),
      Marker(
        markerId: const MarkerId('ユーザ'),
        position: const LatLng(34.10, 134.467),
        icon: userState!.userIcon,
        infoWindow: InfoWindow(title: '現在: ${userState.health?.totalSteps ?? 0}歩'),
      )
    };

    return ColoredBox(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        // TODO(s14t284): お試しで Google Map を表示しているだけであるため、必要に応じて修正する
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
                  'nickname: ${userState.nickname}',
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
            ),
            const Padding(
              padding: EdgeInsetsDirectional.all(16),
            ),
            SizedBox(
              height: 350,
              child: GoogleMap(
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: initialCameraPosition,
                markers: markers,
                polylines: state.polylines,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
