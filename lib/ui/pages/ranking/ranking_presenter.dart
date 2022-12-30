import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:virtualpilgrimage/domain/ranking/ranking.codegen.dart';
import 'package:virtualpilgrimage/domain/ranking/ranking_by_period.codegen.dart';
import 'package:virtualpilgrimage/domain/ranking/ranking_user.codegen.dart';
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/pages/ranking/ranking_state.codegen.dart';

/// ランキングを集計する項目
enum RankingKind { steps, distances }

/// ランキングを集計する期間
enum RankingPeriod { daily, weekly, monthly }

final rankingPresenterProvider =
    StateNotifierProvider.autoDispose<RankingPresenter, RankingState>(RankingPresenter.new);

class RankingPresenter extends StateNotifier<RankingState> {
  RankingPresenter(this._ref)
      : super(RankingState(selectedPeriodTabIndex: RankingPeriod.daily.index));

  final Ref _ref;

  final _periodTabLabels = ['昨日', '週間', '月間'];

  List<String> get periodTabLabels => _periodTabLabels;

  final dateFormat = DateFormat('yyyy/MM/dd');

  /// 期間のタブ選択の切り替えを行う
  Future<void> setSelectedPeriodTabIndex(int index) async => state = state.setPeriodTabIndex(index);

  /// 表示するランキング情報を選択する
  RankingUsers selectRanking(Ranking ranking, RankingKind kind, RankingPeriod period) {
    switch (kind) {
      case RankingKind.steps:
        return selectRankingByPeriod(ranking, period).step;
      case RankingKind.distances:
        return selectRankingByPeriod(ranking, period).distance;
    }
  }

  /// 参照しているランキング情報の期間を選択する
  RankingByPeriod selectRankingByPeriod(Ranking ranking, RankingPeriod period) {
    switch (period) {
      case RankingPeriod.daily:
        return ranking.daily;
      case RankingPeriod.weekly:
        return ranking.weekly;
      case RankingPeriod.monthly:
        return ranking.monthly;
    }
  }

  /// 集計した時間を取得する
  String convertAggregationDate(Ranking? ranking, RankingPeriod period) {
    if (ranking == null) {
      return '不明';
    }
    final rankingByPeriod = selectRankingByPeriod(ranking, period);
    final dateTime = DateTime.fromMillisecondsSinceEpoch(rankingByPeriod.updatedTime);
    return dateFormat.format(dateTime);
  }

  /// プロフィールページに遷移する
  Future<void> moveProfilePage(String userId) async => _ref.read(routerProvider).pushNamed(
        RouterPath.profile,
        queryParams: {
          'userId': userId,
          'canEdit': 'false',
          'previousPagePath': RouterPath.ranking,
        },
      );

  /// デフォルトのプロフィール画像
  String get defaultProfileImageUrl {
    const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
    switch (flavor) {
      case 'prod':
        return 'https://firebasestorage.googleapis.com/v0/b/virtual-pilgrimage-prd.appspot.com/o/icon512.jpg?alt=media';
      case 'dev':
      default:
        return 'https://firebasestorage.googleapis.com/v0/b/virtual-pilgrimage-dev.appspot.com/o/icon512.jpg?alt=media';
    }
  }
}
