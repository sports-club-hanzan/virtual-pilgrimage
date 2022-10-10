import 'package:flutter/material.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';

class ProfileHealthCard extends StatelessWidget {
  const ProfileHealthCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.backgroundColor,
    this.textColor = Colors.white,
    required this.icon,
    super.key,
  });

  final String title;
  final String value;
  final String unit;
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsetsDirectional.all(12),
              child: Column(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: FontStyle.mediumSize,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      color: textColor,
                      fontSize: FontStyle.largeSize,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      unit,
                      style: TextStyle(color: textColor, fontWeight: FontWeight.w900),
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 4,
            child: Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
          )
        ],
      ),
    );
  }
}
