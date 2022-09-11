import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/pages/sign_in/sign_in_presenter.dart';
import 'package:virtualpilgrimage/ui/style/color.dart';

// TODO(s14t284): 仮でユーザの情報を表示しているだけ
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        // TODO(s14t284): タイトルは変更
        title: const Text('virtual pilgrimage'),
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
    late GoogleMapController _mapController;
    const initialCameraPosition = CameraPosition(
      target: LatLng(34.1597388, 134.4675072),
      zoom: 10,
    );
    final markers = {
      const Marker(
        markerId: MarkerId('霊峰寺'),
        position: LatLng(34.1597388, 134.4675072),
        infoWindow: InfoWindow(title: '霊峰寺', snippet: '1箇所目'),
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
            ),
            const Padding(
              padding: EdgeInsetsDirectional.all(16),
            ),
            SizedBox(
              height: 350,
              child: GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: initialCameraPosition,
                markers: markers,
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
