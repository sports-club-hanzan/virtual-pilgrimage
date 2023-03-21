import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/ui/components/bottom_navigation.dart';
import 'package:virtualpilgrimage/ui/components/my_app_bar.dart';
import 'package:virtualpilgrimage/ui/pages/temple/components/temple.dart';
import 'package:virtualpilgrimage/ui/pages/temple/temple_presenter.dart';

class TemplePage extends ConsumerWidget {
  const TemplePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SafeArea(
        child: _TemplePageBody(ref: ref),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

class _TemplePageBody extends StatelessWidget {
  const _TemplePageBody({
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(templeProvider);
    final templeState = state.temples;
    final isLoading = state.loading;
    final scrollController = ref.read(templeProvider).scrollController;
    final user = ref.watch(userStateProvider);

    return ColoredBox(
      color: Theme.of(context).colorScheme.background,
      child: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Opacity(
              // 読み込み中は背景を透過させてローディングを目立たせる
              opacity: isLoading ? 0.25 : 1,
              child: SizedBox(
                height: double.maxFinite,
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: scrollController,
                  child: ListView.builder(
                    addAutomaticKeepAlives: true,
                    shrinkWrap: true,
                    controller: scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      return Temple(templeInfo: templeState[index], user: user);
                    },
                    itemCount: templeState.length,
                  ),
                ),
              ),
            ),
            if (isLoading)
              Center(
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: CircularProgressIndicator(
                    strokeWidth: 16,
                    color: Theme.of(context).colorScheme.primary,
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
