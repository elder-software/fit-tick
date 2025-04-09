import 'package:flutter/material.dart';

class StyledIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const StyledIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IconButton(
      color: theme.colorScheme.primary,
      icon: Icon(icon),
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.all<OutlinedBorder?>(const CircleBorder()),
        side: WidgetStateProperty.all<BorderSide?>(
          BorderSide(
            color: theme.colorScheme.primary,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
