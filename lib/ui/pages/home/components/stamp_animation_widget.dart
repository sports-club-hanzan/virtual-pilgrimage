import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/temple/temple_repository_impl.dart';
import 'package:virtualpilgrimage/ui/pages/home/home_presenter.dart';

class StampAnimationWidget extends HookConsumerWidget {
  const StampAnimationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templeInfo = ref.watch(templeInfoCache);
    final user = ref.watch(userStateProvider);
    final pilgrimageId = user!.pilgrimage.nowPilgrimageId - 1;
    final Widget? image = templeInfo[pilgrimageId] != null ? Image.network(templeInfo[pilgrimageId]!.stampImage) : null;

    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.black54),
      child: image != null ? Center(
        child: ListView(
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 3, end: 0.5),
              duration: const Duration(milliseconds: 750),
              builder: (BuildContext context, double value, _) {
                return Transform.scale(
                  scale: value,
                  child: SizedBox(
                    height: 500,
                    child: image,
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () async {
                ref.read(homeProvider.notifier).state = ref.read(homeProvider).copyWith(stampAnimation: false);
              },
              child: const Text('タップして次を目指そう！'),
            ),
          ],
        ),
      ) : null,
    );
  }
}
