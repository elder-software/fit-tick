import 'package:flutter/material.dart';

class FitTickTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String errorText;
  final bool isPassword;

  const FitTickTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText = '',
    this.errorText = '',
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText.isNotEmpty ? hintText : null,
        errorText: errorText.isNotEmpty ? errorText : null,
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
      ),
      style: TextStyle(color: colorScheme.onSurface),
      obscureText: isPassword,
      autofocus: true,
    );
  }
}
