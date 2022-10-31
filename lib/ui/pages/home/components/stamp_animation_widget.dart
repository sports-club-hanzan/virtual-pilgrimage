import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:virtualpilgrimage/domain/temple/temple_repository.dart';
import 'package:virtualpilgrimage/ui/pages/home/home_presenter.dart';

class StampAnimationWidget extends ConsumerWidget {
  const StampAnimationWidget({
    required this.animationTempleId,
    required this.notifier,
    super.key,
  });

  final int animationTempleId;
  final HomePresenter notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.black54),
      child: Center(
        child: FutureBuilder<Uint8List>(
          future: loadStampImage(ref),
          builder: (context, snapshot) {
            return snapshot.hasData ?
              ListView(
                children: [
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 3, end: 0.5),
                    duration: const Duration(milliseconds: 750),
                    builder: (BuildContext context, double value, _) {
                      return Transform.scale(
                        scale: value,
                        child: SizedBox(
                          height: 500,
                          child: Image.memory(snapshot.data!),
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: notifier.onAnimationClosed,
                    child: const Text('タップして次を目指そう！'),
                  ),
                ],
              ) : const Text('読み込み中');
          },
        ),
      ),
    );
  }

  Future<Uint8List> loadStampImage(WidgetRef ref) async {
    final templeInfo = await ref.watch(templeRepositoryProvider).getTempleInfo(animationTempleId);
    return (await get(Uri.parse(templeInfo.stampImage))).bodyBytes;
  }
}
