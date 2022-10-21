import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:virtualpilgrimage/ui/pages/home/home_presenter.dart';

// TODO(s14t284): お試しで Google Map を表示しているだけであるため、必要に応じて修正する
class GoogleMapView extends StatelessWidget {
  const GoogleMapView(this._ref, {super.key});

  final WidgetRef _ref;

  // FIXME: 一時的に用意しているだけ
  static const initialCameraPosition = CameraPosition(
    target: LatLng(34.1597388, 134.4675072),
    zoom: 10,
  );

  @override
  Widget build(BuildContext context) {
    final state = _ref.watch(homeProvider);
    final notifier = _ref.read(homeProvider.notifier);

    return SizedBox(
      height: 350, // FIXME: 適当に固定値を設定しているので修正する
      child: GoogleMap(
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        tiltGesturesEnabled: false,
        scrollGesturesEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: initialCameraPosition,
        markers: state.markers,
        polylines: state.polylines,
        onMapCreated: notifier.onMapCreated,
        // スクロールジェスチャーが正常にできるような設定
        gestureRecognizers: const {
          Factory<OneSequenceGestureRecognizer>(
            EagerGestureRecognizer.new,
          )
        },
      ),
    );
  }
}
