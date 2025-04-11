import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 64, left: 16, right: 16, bottom: 64),
      child: Stack(
        children: [
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.all(64),
                child: Center(child: Text('Bottom Sheet Content')),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TimerControls(
              onSkipPrevious: () {},
              onPause: () {},
              onSkipNext: () {},
              onClose: () {},
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton.filledTonal(
              icon: const Icon(Icons.close, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TimerControls extends StatelessWidget {
  const TimerControls({
    super.key,
    required this.onSkipPrevious,
    required this.onPause,
    required this.onSkipNext,
    required this.onClose,
  });
  final Function() onSkipPrevious;
  final Function() onPause;
  final Function() onSkipNext;
  final Function() onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.skip_previous, color: theme.colorScheme.onSurface),
            iconSize: 28.0,
            onPressed: onSkipPrevious,
          ),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.shadow,
                  blurRadius: 6,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(Icons.pause, color: theme.colorScheme.onSurface),
              iconSize: 36.0,
              onPressed: onPause,
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.skip_next, color: theme.colorScheme.onSurface),
            iconSize: 28.0,
            onPressed: onSkipNext,
          ),
        ],
      ),
    );
  }
}
