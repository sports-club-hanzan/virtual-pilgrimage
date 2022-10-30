import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:virtualpilgrimage/ui/pages/home/home_presenter.dart';

class GoogleMapView extends ConsumerWidget {
  const GoogleMapView({required this.height, super.key});

  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);
    final notifier = ref.read(homeProvider.notifier);

    return SizedBox(
      height: height,
      child: GoogleMap(
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        tiltGesturesEnabled: false,
        scrollGesturesEnabled: true,
        rotateGesturesEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: state.initialCameraPosition,
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
