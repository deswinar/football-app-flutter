import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.status,
  });

  final String? status;

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    String label = status ?? 'N/A';

    switch (status) {
      case 'NS':
        badgeColor = Colors.grey;
        break;
      case '1H':
      case '2H':
      case 'LIVE':
        badgeColor = Colors.red;
        label = 'Live';
        break;
      case 'FT':
        badgeColor = Colors.green;
        break;
      default:
        badgeColor = Colors.blueGrey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha:0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(color: badgeColor, fontSize: 12),
      ),
    );
  }
}
