import 'package:flutter/material.dart';

class StandardDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const StandardDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      backgroundColor: colorScheme.surfaceContainerHigh,
      title: Text(
        title,
        style: theme.textTheme.headlineSmall?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),
      content: content,
      actions: <Widget>[
        TextButton(
          onPressed: onCancel ?? () => Navigator.of(context).pop(),
          child: Text('Cancel', style: TextStyle(color: colorScheme.primary)),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text('Confirm', style: TextStyle(color: colorScheme.primary)),
        ),
      ],
    );
  }
}
