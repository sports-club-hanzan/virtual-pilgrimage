import 'package:flutter/cupertino.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/ui/pages/profile/profile_presenter.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';

class ProfileText extends StatelessWidget {
  const ProfileText({
    super.key,
    required this.user,
    required this.context,
    required this.notifier,
  });

  final VirtualPilgrimageUser user;
  final BuildContext context;
  final ProfilePresenter notifier;

  @override
  Widget build(BuildContext context) {
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
}

