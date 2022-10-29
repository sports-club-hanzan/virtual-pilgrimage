import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/ui/components/bottom_navigation.dart';
import 'package:virtualpilgrimage/ui/components/molecules/pilgrimage_progress_card.dart';
import 'package:virtualpilgrimage/ui/components/molecules/profile_health_card.dart';
import 'package:virtualpilgrimage/ui/components/my_app_bar.dart';
import 'package:virtualpilgrimage/ui/pages/home/components/google_map_view.dart';

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
    final userState = _ref.watch(userStateProvider);
    final notifier = _ref.read(homeProvider.notifier);

    return ColoredBox(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: ListView(
          children: [
            const GoogleMapView(height: 300),
            pilgrimageProgressCardProvider(context, userState!, _ref),
            _healthCards(context, userState, notifier),
          ],
        ),
      ),
    );
  }

  Widget _healthCards(
    BuildContext context,
    VirtualPilgrimageUser user,
    HomePresenter notifier,
  ) {
    final health = user.health;
    final List<ProfileHealthCard> healthCards = [];
    if (health != null) {
      healthCards.addAll([
        ProfileHealthCard(
          title: '今日の歩数',
          value: health.today.steps.toString(),
          unit: '歩',
          icon: Icons.directions_run_rounded,
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          textColor: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
        ProfileHealthCard(
          title: '今日の移動距離',
          value: notifier.meterToKilometerString(health.today.distance),
          unit: 'km',
          icon: Icons.map_outlined,
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          textColor: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
      ]);
    }
    return SizedBox(
      height: 130,
      child: Column(
        children: [
          Row(children: healthCards),
        ],
      ),
    );
  }
}
