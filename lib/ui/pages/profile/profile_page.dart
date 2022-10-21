import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/components/bottom_navigation.dart';
import 'package:virtualpilgrimage/ui/components/my_app_bar.dart';
import 'package:virtualpilgrimage/ui/components/profile_icon.dart';
import 'package:virtualpilgrimage/ui/pages/profile/components/profile_health_card.dart';
import 'package:virtualpilgrimage/ui/pages/profile/profile_presenter.dart';
import 'package:virtualpilgrimage/ui/style/color.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({
    required this.userId,
    required this.canEdit,
    required this.previousPagePath,
    super.key,
  });

  final String userId;
  final bool canEdit;
  final String previousPagePath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userStateProvider);
    // ユーザ情報が null の場合、何も描画できないのでログインページに遷移させる
    if (userState == null) {
      ref.read(routerProvider).go(RouterPath.signIn);
    }

    final user = ref.watch(profileUserProvider(userId));
    return Scaffold(
      appBar: const MyAppBar(),
      body: SafeArea(
        // TODO(s14t284): loading, error 周りを整理する
        child: user.when(
          data: (data) {
            if (data != null) {
              return _ProfilePageBody(user: data, canEdit: canEdit, ref: ref);
            }
            // TODO(s14t284): 他ユーザの情報を参照できるようになったら　null の場合の UI も実装する
            return const Text('そのユーザは存在しませんでした');
          },
          error: (e, _) {
            return Text(e.toString());
          },
          loading: () {
            return const Text('読み込み中');
          },
        ),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

class _ProfilePageBody extends StatelessWidget {
  const _ProfilePageBody({
    required this.user,
    required this.canEdit,
    required this.ref,
  });

  final VirtualPilgrimageUser user;
  final bool canEdit;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(profileProvider.notifier);
    return ListView(
      children: [
        const SizedBox(
          height: 24,
        ),

        /// ユーザアイコン
        Center(
          child: Stack(
            children: [
              ProfileIconWidget(
                iconUrl: user.userIconUrl,
                size: 128,
                onTap: notifier.updateProfileImage,
              ),
              if (canEdit)
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: _buildUserIconEditButton(context),
                ),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),

        /// ユーザの基礎情報
        // TODO(s14t284): お遍路の進捗状況も表示する
        _buildProfile(context, user),
      ],
    );
  }

  Widget _buildUserIconEditButton(BuildContext context) => ClipOval(
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.edit,
            color: ColorStyle.white,
            size: 20,
          ),
        ),
      );

  Widget _buildProfile(BuildContext context, VirtualPilgrimageUser user) {
    final notifier = ref.read(profileProvider.notifier);
    final state = ref.watch(profileProvider);
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
            value: h.distance.toString(),
            unit: 'm',
            backgroundColor: Colors.lightBlue,
            icon: Icons.map_outlined,
          ),
          ProfileHealthCard(
            title: '消費カロリー',
            value: h.burnedCalorie.toString(),
            unit: 'kcal',
            backgroundColor: Colors.orangeAccent,
            icon: Icons.local_fire_department_outlined,
          ),
        ]);
      }
    }
    return Column(
      children: [
        Text(
          '${user.nickname} さん',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: FontSize.largeSize),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${notifier.getAgeString(user.birthDay)} ${notifier.getGenderString(user.gender)}',
              style: const TextStyle(
                fontSize: FontSize.largeSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
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
        const SizedBox(height: 12),
        // クラッシュ対策のため、全てのヘルスチェック情報を取得できているときに表示
        if (healthCards.length == notifier.tabLabels().length)
          Row(children: healthCards[state.selectedTabIndex]),
      ],
    );
  }
}
