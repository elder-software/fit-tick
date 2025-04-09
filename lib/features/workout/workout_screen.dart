import 'package:fit_tick_mobile/data/exercise/exercise.dart';
import 'package:fit_tick_mobile/data/workout/workout.dart';
import 'package:fit_tick_mobile/features/workout/workout_bloc.dart';
import 'package:fit_tick_mobile/ui/counter.dart';
import 'package:fit_tick_mobile/ui/icon.dart';
import 'package:fit_tick_mobile/ui/standard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WorkoutBloc>().add(InitialEvent());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final workoutId = args?['workoutId'] as String?;
      if (workoutId != null) {
        context.read<WorkoutBloc>().add(LoadScreen(workoutId: workoutId));
      } else {
        print("Error: workoutId is null");
        context.read<WorkoutBloc>().add(
          WorkoutError(message: 'Could not load workout'),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutBloc, WorkoutState>(
      builder: (context, state) {
        String pageTitle;
        Widget bodyContent;
        List<Widget> pageTitleButtons = []; // Default to empty

        if (state is WorkoutLoaded) {
          pageTitle = state.workout.name; // Use workout name
          pageTitleButtons = [
            StyledIconButton(
              icon: Icons.more_vert,
              showBorder: false,
              onPressed: () => {},
            ),
          ];
          bodyContent = WorkoutLoadedWidget(
            workout: state.workout,
            exercises: state.exercises,
          );
        } else if (state is ErrorScreen) {
          pageTitle = 'Error';
          bodyContent = Center(child: Text(state.message));
        } else {
          // Handle WorkoutInitial or other loading states
          pageTitle = 'Loading Workout...';
          bodyContent = const Center(child: CircularProgressIndicator());
        }

        // Build the screen UI based on the current state
        return FitTickStandardScreen(
          topBarTitle: 'Workout', // Keep top bar title consistent
          pageTitle: pageTitle, // Dynamic page title
          pageTitleButtons: Row(
            // Use defined buttons, ensure Row takes minimum space
            mainAxisSize: MainAxisSize.min,
            children: pageTitleButtons,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          children: [bodyContent], // Place the dynamic content here
        );
      },
    );
  }
}

class WorkoutLoadedWidget extends StatelessWidget {
  final Workout workout;
  final List<Exercise> exercises;
  const WorkoutLoadedWidget({
    super.key,
    required this.workout,
    required this.exercises,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Text('Round', style: theme.textTheme.titleMedium)),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Counter(onChanged: (value) => print(value)),
              Counter(onChanged: (value) => print(value)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Divider(height: 16),
        ...exercises.map((exercise) => Text('Exercise: ${exercise.name}')),
      ],
    );
  }
}
