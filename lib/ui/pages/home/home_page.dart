import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/ui/components/bottom_navigation.dart';
import 'package:virtualpilgrimage/ui/components/molecules/pilgrimage_progress_card.dart';
import 'package:virtualpilgrimage/ui/components/my_app_bar.dart';
import 'package:virtualpilgrimage/ui/pages/home/components/google_map_view.dart';
import 'package:virtualpilgrimage/ui/pages/home/components/health_cards.dart';
import 'package:virtualpilgrimage/ui/pages/home/components/stamp_animation_widget.dart';

import 'home_presenter.dart';

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
    final homeState = _ref.watch(homeProvider);
    final userState = _ref.watch(userStateProvider);

    return ColoredBox(
      color: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                GoogleMapView(height: MediaQuery.of(context).size.height / 5 * 2),
                pilgrimageProgressCardProvider(context, userState, _ref),
                const HealthCards()
              ],
            ),
            // スタンプが押される時、札所のIDが指定される（0より大きい値が設定される）
            if (homeState.animationTempleId > 0)
              StampAnimationWidget(animationTempleId: homeState.animationTempleId)
          ],
        ),
      ),
    );
  }
}
