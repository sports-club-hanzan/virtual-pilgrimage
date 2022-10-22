import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/temple/temple_info.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/temple/temple_repository_impl.dart';
import 'package:virtualpilgrimage/ui/components/bottom_navigation.dart';
import 'package:virtualpilgrimage/ui/components/my_app_bar.dart';

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
    final templeState = ref.read(templeInfoCache.notifier);
    final temples = templeState.state.values.toList()
      ..sort((a, b) => a.id.compareTo(b.id));

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return _buildTemple(context, temples[index]);
      },
      itemCount: 88,
    );
  }

  Widget _buildTemple(BuildContext context, TempleInfo templeInfo) {
    return SizedBox(
      width: 144,
      height: 120,
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.all(10),
        child: ListTile(
          leading:
          Image(
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
            '${templeInfo.distance} m',
            style: const TextStyle(
              color: Color(0xffcdcdcd),
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
