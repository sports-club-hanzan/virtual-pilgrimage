import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_crashlytics_provider.dart';
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/components/bottom_navigation.dart';
import 'package:virtualpilgrimage/ui/components/molecules/pilgrimage_progress_card.dart';
import 'package:virtualpilgrimage/ui/components/my_app_bar.dart';
import 'package:virtualpilgrimage/ui/pages/profile/components/health_cards.dart';
import 'package:virtualpilgrimage/ui/pages/profile/components/profile_icon.dart';
import 'package:virtualpilgrimage/ui/pages/profile/components/profile_text.dart';
import 'package:virtualpilgrimage/ui/pages/profile/profile_presenter.dart';

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
        // TODO(s14t284): error 時のUIを整理する
        child: ColoredBox(
          color: Theme.of(context).colorScheme.background,
          child: user.when(
            data: (data) {
              if (data != null) {
                return _ProfilePageBody(user: data, canEdit: canEdit);
              }
              // TODO(s14t284): 他ユーザの情報を参照できるようになったら　null の場合の UI も実装する
              return const Text('そのユーザは存在しませんでした');
            },
            error: (e, s) {
              ref.read(firebaseCrashlyticsProvider).recordError(e, s);
              return const Text('ユーザのヘルスケア情報の取得に失敗しました');
            },
            loading: () {
              return ProfilePageLoadingBody(user: userState!);
            },
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

class _ProfilePageBody extends ConsumerWidget {
  const _ProfilePageBody({
    required this.user,
    required this.canEdit,
  });

  final VirtualPilgrimageUser user;
  final bool canEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(profileProvider.notifier);

    return ListView(
      children: [
        ProfileIcon(user: user, canEdit: canEdit, context: context, notifier: notifier),
        ProfileText(user: user, context: context, notifier: notifier),
        const HealthCards(),
        pilgrimageProgressCardProvider(context, ref),
      ],
    );
  }
}

// ローディング時のボディ
// お遍路の進捗やヘルスケア情報をローディングで埋めている
// MEMO: 実際はヘルスケア情報だけを取得してきているが、UIのわかりやすさ的にお遍路進捗もローディングで隠している
class ProfilePageLoadingBody extends ConsumerWidget {
  const ProfilePageLoadingBody({required this.user, super.key});

  final VirtualPilgrimageUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(profileProvider.notifier);
    return ListView(
      children: [
        ProfileIcon(user: user, canEdit: false, context: context, notifier: notifier),
        ProfileText(user: user, context: context, notifier: notifier),
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Center(
            child: SizedBox(
              height: 120,
              width: 120,
              child: CircularProgressIndicator(
                strokeWidth: 16,
                color: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
