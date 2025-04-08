import 'package:fit_tick_mobile/ui/standard_screen.dart';
import 'package:flutter/material.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    final String workoutId =
        ModalRoute.of(context)?.settings.arguments as String? ?? 'No ID';

    return FitTickStandardScreen(
      topBarTitle: 'Workout',
      pageTitle: 'Workout Details',
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      children: [Center(child: Text('Details for workout: $workoutId'))],
    );
  }
}
