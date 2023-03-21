import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ranking_state.codegen.freezed.dart';

@freezed
class RankingState with _$RankingState {
  factory RankingState({
    required ScrollController scrollController,
  }) = _RankingState;

  const RankingState._();

  void addListener(VoidCallback listener) => scrollController.addListener(listener);
}
