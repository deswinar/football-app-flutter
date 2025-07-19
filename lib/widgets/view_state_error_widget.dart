import 'package:flutter/material.dart';

class ViewStateErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final double? height;

  const ViewStateErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SizedBox(
      height: height ?? 140,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: colorScheme.error, size: 40),
            const SizedBox(height: 8),
            Text(
              message,
              style: textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: onRetry,
              icon: Icon(Icons.refresh, color: theme.colorScheme.primary),
              label: Text(
                'Try Again',
                style: TextStyle(color: theme.colorScheme.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
