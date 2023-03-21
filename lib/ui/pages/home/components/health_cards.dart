import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/ui/components/molecules/profile_health_card.dart';
import 'package:virtualpilgrimage/ui/wording_helper.dart';

class HealthCards extends ConsumerWidget {
  const HealthCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userStateProvider);
    if (user == null) {
      return Container();
    }

    final health = user.health;
    final List<ProfileHealthCard> healthCards = [];
    if (health != null) {
      healthCards.addAll([
        ProfileHealthCard(
          title: '今日の歩数',
          value: health.today.steps.toString(),
          unit: '歩',
          icon: Icons.directions_run_rounded,
        ),
        ProfileHealthCard(
          title: '今日の移動距離',
          value: WordingHelper.meterToKilometerString(health.today.distance),
          unit: 'km',
          icon: Icons.map_outlined,
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
