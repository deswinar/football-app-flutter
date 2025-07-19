import 'package:flutter/material.dart';

class ViewStateErrorMinimalWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ViewStateErrorMinimalWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            message,
            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.refresh, size: 18, color: theme.colorScheme.primary),
          onPressed: onRetry,
          tooltip: 'Retry',
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }
}
