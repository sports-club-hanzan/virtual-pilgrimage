import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/application/raning/ranking_repository.dart';
import 'package:virtualpilgrimage/domain/ranking/ranking.codegen.dart';
import 'package:virtualpilgrimage/domain/ranking/ranking_user.codegen.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_crashlytics_provider.dart';
import 'package:virtualpilgrimage/ui/components/bottom_navigation.dart';
import 'package:virtualpilgrimage/ui/components/my_app_bar.dart';
import 'package:virtualpilgrimage/ui/components/profile_icon.dart';
import 'package:virtualpilgrimage/ui/pages/ranking/components/ranking_tab_bars.dart';
import 'package:virtualpilgrimage/ui/pages/ranking/ranking_presenter.dart';

final rankingProvider = FutureProvider<Ranking>((ref) async {
  final repository = ref.read(rankingRepositoryProvider);
  return repository.get();
});

class RankingPage extends ConsumerStatefulWidget {
  const RankingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RankingPageState();
}

class _RankingPageState extends ConsumerState<RankingPage> with TickerProviderStateMixin {
  late final TabController _rankingKindTabController;
  late final TabController _periodTabController;

  @override
  void initState() {
    _rankingKindTabController = TabController(length: 2, vsync: this);
    _periodTabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kindTabBar = TabBar(
      controller: _rankingKindTabController,
      labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
      indicatorColor: Theme.of(context).colorScheme.onPrimaryContainer,
      indicatorSize: TabBarIndicatorSize.label,
      unselectedLabelColor: Theme.of(context).colorScheme.onPrimaryContainer,
      tabs: const [
        Tab(text: '歩数', icon: Icon(Icons.directions_run_rounded)),
        Tab(text: '距離', icon: Icon(Icons.map_outlined)),
      ],
    );
    final periodTabBar = TabBar(
      controller: _periodTabController,
      labelColor: Theme.of(context).colorScheme.onSecondaryContainer,
      unselectedLabelColor: Theme.of(context).colorScheme.onSecondaryContainer,
      tabs: ref
          .read(rankingPresenterProvider.notifier)
          .periodTabLabels
          .map((l) => Tab(text: l))
          .toList(),
      indicatorColor: Theme.of(context).colorScheme.secondary,
      indicatorWeight: 2,
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MyAppBar(tabBar: RankingTabBars(tabBars: [kindTabBar, periodTabBar])),
        body: SafeArea(
          child: TabBarView(
            controller: _rankingKindTabController,
            children: [
              _RankingPageBody(
                  ref: ref, periodTabController: _periodTabController, kind: RankingKind.steps),
              _RankingPageBody(
                  ref: ref, periodTabController: _periodTabController, kind: RankingKind.distances),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}

class _RankingPageBody extends StatelessWidget {
  const _RankingPageBody({
    required this.ref,
    required this.periodTabController,
    required this.kind,
  });

  final WidgetRef ref;
  final TabController periodTabController;
  final RankingKind kind;

  @override
  Widget build(BuildContext context) {
    final ranking = ref.watch(rankingProvider);
    final notifier = ref.read(rankingPresenterProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 8),
          child: Text(
            '最終更新日: ${notifier.convertAggregationDate(ranking.value, RankingPeriod.values[periodTabController.index])} (毎日4時頃更新予定)',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: periodTabController,
            children: [
              _buildRankingList(context, ref, ranking, kind, RankingPeriod.daily),
              _buildRankingList(context, ref, ranking, kind, RankingPeriod.weekly),
              _buildRankingList(context, ref, ranking, kind, RankingPeriod.monthly),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildRankingList(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<Ranking> ranking,
    RankingKind kind,
    RankingPeriod period,
  ) {
    final loginUserState = ref.watch(userStateProvider);
    return Column(
      children: [
        ranking.when(
          data: (ranking) {
            final viewableRanking =
                ref.read(rankingPresenterProvider.notifier).selectRanking(ranking, kind, period);
            return Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 10 * 6,
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final isLoginUser = viewableRanking.users[index].userId == loginUserState?.id;
                      return _buildRankingUser(
                          context, ref, viewableRanking.users, isLoginUser, index, kind);
                    },
                    itemCount: viewableRanking.users.length,
                  ),
                ),
              ),
            );
          },
          // TODO(s14t284): error 時のUIを整理する
          error: (Object error, StackTrace stackTrace) {
            ref.read(firebaseCrashlyticsProvider).recordError(error, stackTrace);
            return const Text('ランキング情報が取得できませんでした');
          },
          loading: () {
            return Center(
              child: SizedBox(
                height: 120,
                width: 120,
                child: CircularProgressIndicator(
                  strokeWidth: 16,
                  color: Theme.of(context).colorScheme.primary,
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget _buildRankingUser(
    BuildContext context,
    WidgetRef ref,
    List<RankingUser> users,
    bool isLoginUser,
    int rank,
    RankingKind kind,
  ) {
    final user = users[rank];
    final notifier = ref.read(rankingPresenterProvider.notifier);
    return ListTile(
      tileColor: isLoginUser ? Theme.of(context).colorScheme.primaryContainer : Colors.white,
      leading: SizedBox(
        width: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('${rank + 1} 位', style: const TextStyle(fontWeight: FontWeight.bold)),
            ProfileIconWidget(
              iconUrl: user.userIconUrl != '' ? user.userIconUrl : notifier.defaultProfileImageUrl,
              size: 48,
            ),
          ],
        ),
      ),
      title: Text(user.nickname),
      trailing: Text(
        user.value.toString() + (kind == RankingKind.steps ? ' 歩' : ' m'),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: () => notifier.moveProfilePage(user.userId),
    );
  }
}
