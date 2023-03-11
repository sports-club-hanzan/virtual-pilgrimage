import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/ui/components/molecules/profile_health_card.dart';
import 'package:virtualpilgrimage/ui/pages/profile/profile_presenter.dart';
import 'package:virtualpilgrimage/ui/style/color.dart';
import 'package:virtualpilgrimage/ui/wording_helper.dart';

class HealthCards extends ConsumerWidget {
  const HealthCards({super.key, required this.user});

  final VirtualPilgrimageUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileProvider);
    final notifier = ref.read(profileProvider.notifier);

    final health = user.health;
    final List<List<ProfileHealthCard>> healthCards = [];
    if (health != null) {
      final healthByPeriod = [health.today, health.yesterday, health.week, health.month];
      for (final h in healthByPeriod) {
        healthCards.add([
          ProfileHealthCard(
            title: '歩数',
            value: h.steps.toString(),
            unit: '歩',
            backgroundColor: Colors.lightGreen,
            icon: Icons.directions_run_rounded,
          ),
          ProfileHealthCard(
            title: '移動距離',
            value: WordingHelper.meterToKilometerString(h.distance),
            unit: 'km',
            backgroundColor: Colors.lightBlue,
            icon: Icons.map_outlined,
          ),
          ProfileHealthCard(
            title: 'カロリー',
            value: h.burnedCalorie.toString(),
            unit: 'kcal',
            backgroundColor: Colors.orangeAccent,
            icon: Icons.local_fire_department_outlined,
          ),
        ]);
      }
    }

    return SizedBox(
      height: 180,
      child: Column(
        children: [
          FlutterToggleTab(
            width: 60,
            labels: notifier.tabLabels(),
            selectedLabelIndex: (index) {
              notifier.setSelectedTabIndex(index);
            },
            selectedTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorStyle.white,
            ),
            unSelectedTextStyle: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w400,
            ),
            selectedIndex: state.selectedTabIndex,
          ),
          const SizedBox(height: 8),
          // クラッシュ対策のため、全てのヘルスチェック情報を取得できているときに表示
          if (healthCards.length == notifier.tabLabels().length)
            Row(children: healthCards[state.selectedTabIndex]),
        ],
      ),
    );
  }
}
