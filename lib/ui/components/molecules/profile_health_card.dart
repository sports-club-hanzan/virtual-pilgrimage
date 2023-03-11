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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(top: 8, bottom: 8, start: 12, end: 12),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      title,
                      style: TextStyle(
                        color: textColor,
                        fontSize: FontSize.mediumSize,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      color: textColor,
                      fontSize: FontSize.mediumLargeSize,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      unit,
                      style: TextStyle(
                        fontSize: FontSize.mediumSize,
                        color: textColor,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(top: 12, right: 8, child: Icon(icon, color: textColor, size: 20))
        ],
      ),
    );
  }
}
