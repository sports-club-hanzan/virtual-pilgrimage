import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/temple_info.codegen.dart';
import 'package:virtualpilgrimage/application/pilgrimage/temple_repository.dart';
import 'package:virtualpilgrimage/ui/pages/home/home_presenter.dart';
import 'package:virtualpilgrimage/ui/wording_helper.dart';

class StampAnimation {
  late Uint8List image;
  late TempleInfo templeInfo;
}

class StampAnimationWidget extends ConsumerWidget {
  const StampAnimationWidget({
    required this.animationTempleId,
    super.key,
  });

  final int animationTempleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ColoredBox(
      color: Colors.black54,
      child: Center(
        child: FutureBuilder<StampAnimation>(
          future: loadStampImage(ref),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? AlertDialog(
                    backgroundColor: Colors.transparent,
                    title: Center(
                      child: Text(
                        '${snapshot.data!.templeInfo.id}番 ${WordingHelper.templeNameFilter(snapshot.data!.templeInfo.name)}に到着',
                        style: const TextStyle(
                          color: Color(0xFFeeff41),
                        ),
                      ),
                    ),
                    content: TweenAnimationBuilder(
                      tween: Tween<double>(begin: 6, end: 1),
                      duration: const Duration(milliseconds: 750),
                      builder: (BuildContext context, double value, _) {
                        return Transform.scale(
                          scale: value,
                          child: SizedBox(
                            height: 500,
                            child: Image.memory(snapshot.data!.image),
                          ),
                        );
                      },
                    ),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      ElevatedButton(
                        onPressed: ref.read(homeProvider.notifier).onAnimationClosed,
                        child: const Text('タップして次を目指そう！'),
                      ),
                    ],
                  )
                : const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Future<StampAnimation> loadStampImage(WidgetRef ref) async {
    final StampAnimation stampAnimation = StampAnimation();
    final TempleInfo templeInfo =
        await ref.read(templeRepositoryProvider).getTempleInfo(animationTempleId);

    stampAnimation
      ..templeInfo = templeInfo
      ..image = (await get(Uri.parse(templeInfo.stampImage))).bodyBytes;
    return stampAnimation;
  }
}
