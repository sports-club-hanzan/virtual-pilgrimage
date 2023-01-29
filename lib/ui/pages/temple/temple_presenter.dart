import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/application/pilgrimage/temple_repository.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/temple_info.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/pilgrimage/temple_repository_impl.dart';
import 'package:virtualpilgrimage/ui/pages/temple/temple_state.codegen.dart';

final templeProvider = StateNotifierProvider<TemplePresenter, TempleState>(TemplePresenter.new);

class TemplePresenter extends StateNotifier<TempleState> {
  TemplePresenter(this._ref) : super(TempleState(scrollController: ScrollController())) {
    // home page でお寺情報の読み込みが完了していない時のために念の為、repositoryからお寺情報を全て取得してキャッシュしておく
    _ref.read(templeRepositoryProvider).getTempleInfoAll();
    // 1番札所からソートして格納
    _temples = SplayTreeMap.from(_ref.watch(templeInfoCache), (a, b) => a.compareTo(b));

    // 1番端までスクロールしたら表示するお寺情報数を増やす
    // 徐々に表示する情報を増やすことで、画像の読み込みを1度に最大10件までに抑えることができる
    state.addListener(() {
      if (state.scrollController.offset == state.scrollController.position.maxScrollExtent) {
        fetchTempleInfo();
      }
    });
    fetchTempleInfo();
  }

  final Ref _ref;
  late final Map<int, TempleInfo> _temples;

  int loadedTempleImageIdSnapshot = 0;

  // 一度に読み込む情報の数
  final int fetchOnceLoadingNumber = 8;

  /// 札所の情報を一部読み込む
  ///
  /// 実際に読み込む情報はcacheされているので、次にページで読み込みたい札所の数を取得して、キャッシュから情報を返すだけ
  Future<void> fetchTempleInfo() async {
    // min(現在の読み込み件数 + 8, 札所情報の上限)
    final int maxLoadingNumber =
        min(loadedTempleImageIdSnapshot + fetchOnceLoadingNumber, _temples.length);
    loadedTempleImageIdSnapshot = maxLoadingNumber;
    state = state.updateTemples(_temples.values.toList().sublist(0, maxLoadingNumber));
  }
}
