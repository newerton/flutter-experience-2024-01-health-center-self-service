import 'package:flutter/material.dart';
import 'package:health_center_core/health_center_core.dart';

class DocumentsBoxWidget extends StatelessWidget {
  const DocumentsBoxWidget(
      {super.key,
      required this.uploaded,
      required this.icon,
      required this.title,
      required this.count,
      required this.onTap});

  final bool uploaded;
  final Widget icon;
  final String title;
  final int count;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final countLabel = count > 0 ? '($count)' : '';
    return Expanded(
        child: InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: uploaded ? HealthCenterTheme.lightOrangeColor : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: HealthCenterTheme.orangeColor),
        ),
        child: Column(
          children: [
            Expanded(child: icon),
            Text('$title $countLabel',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: HealthCenterTheme.orangeColor,
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
      ),
    ));
  }
}
