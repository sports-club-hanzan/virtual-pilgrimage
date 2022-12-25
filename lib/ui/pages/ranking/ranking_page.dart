import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/application/raning/ranking_repository.dart';
import 'package:virtualpilgrimage/domain/ranking/ranking.codegen.dart';
import 'package:virtualpilgrimage/ui/components/bottom_navigation.dart';
import 'package:virtualpilgrimage/ui/components/my_app_bar.dart';

final rankingProvider = FutureProvider<Ranking>((ref) async {
  final repository = ref.read(rankingRepositoryProvider);
  return repository.get();
});

class RankingPage extends ConsumerWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SafeArea(
        child: _RankingPageBody(ref: ref),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

class _RankingPageBody extends StatelessWidget {
  const _RankingPageBody({required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final ranking = ref.watch(rankingProvider);

    return ranking.when(
      data: (ranking) => Text(ranking.toString()),
      error: (Object error, StackTrace stackTrace) {
        return Text(error.toString());
      },
      loading: () {
        return CircularProgressIndicator(
          strokeWidth: 16,
          color: Theme.of(context).colorScheme.primary,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        );
      },
    );
  }
}
