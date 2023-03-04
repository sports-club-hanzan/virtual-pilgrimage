import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/application/pilgrimage/temple_repository.dart';
import 'package:virtualpilgrimage/domain/exception/database_exception.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/temple_info.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_crashlytics_provider.dart';
import 'package:virtualpilgrimage/ui/pages/temple/temple_state.codegen.dart';

final templeProvider = StateNotifierProvider<TemplePresenter, TempleState>(TemplePresenter.new);

class TemplePresenter extends StateNotifier<TempleState> {
  TemplePresenter(this._ref) : super(TempleState(scrollController: ScrollController())) {
    _templeRepository = _ref.read(templeRepositoryProvider);
    // 1番端までスクロールしたら表示するお寺情報数を増やす
    // 徐々に表示する情報を増やすことで、画像の読み込みを1度に最大8件までに抑えることができる
    state.addListener(() {
      if (state.scrollController.offset == state.scrollController.position.maxScrollExtent) {
        fetchTempleInfo();
      }
    });

    fetchTempleInfo();
  }

  final Ref _ref;
  late final TempleRepository _templeRepository;
  List<TempleInfo> _temples = [];

  int loadedTempleImageIdSnapshot = 0;

  // 一度に読み込む情報の数
  final int fetchOnceLoadingNumber = 8;

  // 札所情報の上限数
  final int maxTempleNumber = 88;

  /// 札所の情報を一部読み込む
  ///
  /// 実際に読み込む情報はcacheされているので、次にページで読み込みたい札所の数を取得して、キャッシュから情報を返すだけ
  Future<void> fetchTempleInfo() async {
    // 既に全ての情報を読み込み済みだったら何もしない
    if (loadedTempleImageIdSnapshot == maxTempleNumber) {
      return;
    }
    state = state.toLoading();
    // min(現在の読み込み件数 + 8, 札所情報の上限)
    loadedTempleImageIdSnapshot =
        min(loadedTempleImageIdSnapshot + fetchOnceLoadingNumber, maxTempleNumber);
    try {
      final newTemples =
          await _templeRepository.getTempleInfoWithPaging(limit: fetchOnceLoadingNumber);
      // 重複を排除してリスト化し、1番札所からソートして格納
      _temples = [...{..._temples, ...newTemples}];
      _temples.sort((a, b) => a.id > b.id ? 1 : -1);
      state = state.updateTemples(_temples).endLoading();
    } on DatabaseException catch (exception) {
      unawaited(_ref.read(firebaseCrashlyticsProvider).recordError(exception, null));
      state = state.endLoading();
    }
  }
}
