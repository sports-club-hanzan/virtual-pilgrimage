import 'package:flutter/material.dart';

// プロフィール画像を表示するWidget
class ProfileIconWidget extends StatelessWidget {
  const ProfileIconWidget({
    super.key,
    required this.iconUrl,
    required this.size,
    this.onTap,
  });

  final String iconUrl;
  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final image = NetworkImage(iconUrl);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: size,
          height: size,
          child: InkWell(
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
