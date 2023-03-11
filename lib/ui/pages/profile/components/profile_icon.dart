import 'package:flutter/material.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/ui/components/molecules/fail_upload_image_dialog.dart';
import 'package:virtualpilgrimage/ui/components/profile_icon.dart';
import 'package:virtualpilgrimage/ui/pages/profile/profile_presenter.dart';
import 'package:virtualpilgrimage/ui/style/color.dart';

class ProfileIcon extends StatefulWidget {
  const ProfileIcon({
    super.key,
    required this.user,
    required this.canEdit,
    required this.context,
    required this.notifier,
  });

  final VirtualPilgrimageUser user;
  final bool canEdit;
  final BuildContext context;
  final ProfilePresenter notifier;

  @override
  State<StatefulWidget> createState() => ProfileIconState();
}

class ProfileIconState extends State<ProfileIcon> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 150,
        width: 130,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: ProfileIconWidget(
                iconUrl: widget.user.userIconUrl,
                size: 128,
                onTap: () async {
                  final result = await widget.notifier.updateProfileImage(context);
                  // 更新できなかった場合、ダイアログを出す
                  if (!result) {
                    // すでにマウントが終わっている場合はスキップ
                    if (!mounted) {
                      return;
                    }
                    await showDialog<void>(
                      context: context,
                      builder: (BuildContext context) => const FailUploadImageDialog(),
                    );
                  }
                },
              ),
            ),
            // ユーザアイコンの編集ボタン
            if (widget.canEdit)
              Positioned(
                bottom: 0,
                right: 4,
                child: ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Theme.of(context).primaryColor,
                    child: const Icon(
                      Icons.edit,
                      color: ColorStyle.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
