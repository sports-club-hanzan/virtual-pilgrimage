import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';

class ProfileHealthCard extends StatelessWidget {
  const ProfileHealthCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    super.key,
  });

  final String title;
  final String value;
  final String unit;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceVariant,
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
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.kosugiMaru().fontFamily,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: FontSize.mediumLargeSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      unit,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 8,
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
