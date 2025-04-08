import 'package:flutter/material.dart';

class StandardFloatingActionButton extends StatelessWidget {
  const StandardFloatingActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: colorScheme.tertiaryContainer,
      foregroundColor: colorScheme.onTertiaryContainer,
      child: Icon(icon),
    );
  }
}

// Custom FAB location to center it and move it further up
class CenterUpFloatingActionButtonLocation
    extends FloatingActionButtonLocation {
  const CenterUpFloatingActionButtonLocation(this.additionalOffsetY);

  final double additionalOffsetY;
  // Standard margin for FloatingActionButtonLocation.float variants
  static const double _defaultFabMargin = 32.0;

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    // Calculate the x coordinate to center the FAB
    final double fabX =
        (scaffoldGeometry.scaffoldSize.width -
            scaffoldGeometry.floatingActionButtonSize.width) /
        2.0;

    // Calculate the y coordinate: bottom edge - fab height - standard margin - additional offset
    final double fabY =
        scaffoldGeometry.scaffoldSize.height -
        scaffoldGeometry.floatingActionButtonSize.height -
        _defaultFabMargin -
        additionalOffsetY; // Apply the extra vertical offset

    return Offset(fabX, fabY);
  }

  @override
  String toString() =>
      'CenterUpFloatingActionButtonLocation(additionalOffsetY: $additionalOffsetY)';
}
