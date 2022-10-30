import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/temple/temple_info.codegen.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/temple/temple_repository_impl.dart';
import 'package:virtualpilgrimage/ui/components/bottom_navigation.dart';
import 'package:virtualpilgrimage/ui/components/my_app_bar.dart';
import 'package:virtualpilgrimage/ui/pages/temple/temple_detail_dialog.dart';

class TemplePage extends ConsumerWidget {
  const TemplePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SafeArea(
        child: _TemplePageBody(ref: ref),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

class _TemplePageBody extends StatelessWidget {
  const _TemplePageBody({
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final temples = ref.watch(templeInfoCache);
    final user = ref.watch(userStateProvider);

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return _buildTemple(context, temples[index + 1]!, user!);
      },
      itemCount: temples.length,
    );
  }

  Widget _buildTemple(BuildContext context, TempleInfo templeInfo, VirtualPilgrimageUser user) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Image(
          width: 100,
          height: 80,
          image: NetworkImage(
            templeInfo.images[0],
          ),
        ),
          title: Text(
            templeInfo.name,
            style: const TextStyle(
              color: Color(0xff7b61ff),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            '${templeInfo.prefecture}・${templeInfo.distance}m',
            style: const TextStyle(
              color: Colors.black38,
              fontSize: 12,
            ),
          ),
          onTap: () => {
            if (user.pilgrimage.nowPilgrimageId >= templeInfo.id || 1 < user.pilgrimage.lap) {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return TempleDetailDialog(templeInfo: templeInfo);
                },
              )
            }
          },
        ),
      );
  }
}
