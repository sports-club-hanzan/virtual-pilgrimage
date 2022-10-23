import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:virtualpilgrimage/domain/temple/temple_info.codegen.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_crashlytics_provider.dart';
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/components/bottom_navigation.dart';
import 'package:virtualpilgrimage/ui/components/molecules/pilgrimage_progress_card.dart';
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
          error: (e, s) {
            ref.read(firebaseCrashlyticsProvider).recordError(e, s);
            return const Text('ユーザ情報の取得に失敗しました');
          },
          loading: () {
            return const CircularProgressIndicator();
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
    return ListView(
      children: [
        _userIcon(context),
        _userProfile(context),
        _healthCards(context, user),
        _pilgrimageProgress(context, user),
      ],
    );
  }

  Widget _userIcon(BuildContext context) {
    final notifier = ref.read(profileProvider.notifier);
    return Center(
      child: SizedBox(
        height: 150,
        width: 130,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: ProfileIconWidget(
                iconUrl: user.userIconUrl,
                size: 128,
                onTap: notifier.updateProfileImage,
              ),
            ),
            // ユーザアイコンの編集ボタン
            if (canEdit)
              Positioned(
                bottom: 0,
                right: 4,
                child: ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Theme.of(context).primaryColor,
                    child: const Icon(
                      Icons.edit,
                      color: ColorStyle.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _userProfile(BuildContext context) {
    final notifier = ref.read(profileProvider.notifier);
    return SizedBox(
      height: 110,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 0),
            child: Text(
              '${user.nickname} さん',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: FontSize.largeSize),
            ),
          ),
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
        ],
      ),
    );
  }

  Widget _healthCards(BuildContext context, VirtualPilgrimageUser user) {
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
            value: notifier.meterToKilometerString(h.distance),
            unit: 'km',
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
    return SizedBox(
      height: 200,
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
          const SizedBox(height: 12),
          // クラッシュ対策のため、全てのヘルスチェック情報を取得できているときに表示
          if (healthCards.length == notifier.tabLabels().length)
            Row(children: healthCards[state.selectedTabIndex]),
        ],
      ),
    );
  }

  Widget _pilgrimageProgress(BuildContext context, VirtualPilgrimageUser user) {
    final notifier = ref.read(profileProvider.notifier);
    return FutureBuilder<TempleInfo>(
      future: notifier.getNextPilgrimageTempleInfo(user),
      builder: (BuildContext context, AsyncSnapshot<TempleInfo> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.requireData;
          return SizedBox(
            height: 160,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: PilgrimageProgressCard(
                pilgrimageInfo: user.pilgrimage,
                templeInfo: data,
              ),
            ),
          );
        }
        // TODO(s14t284): 取得できなかった場合のUIを改善する
        return const Text('お遍路の進捗状況が取得できませんでした');
      },
    );
  }
}
