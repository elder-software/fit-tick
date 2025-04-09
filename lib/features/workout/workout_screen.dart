import 'package:fit_tick_mobile/data/exercise/exercise.dart';
import 'package:fit_tick_mobile/data/workout/workout.dart';
import 'package:fit_tick_mobile/features/workout/workout_bloc.dart';
import 'package:fit_tick_mobile/features/workout/workout_exercise_card.dart';
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
        List<Widget> pageTitleButtons = [];

        if (state is WorkoutLoaded) {
          pageTitle = state.workout.name;
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
          pageTitle = 'Loading Workout...';
          bodyContent = const Center(child: CircularProgressIndicator());
        }

        return FitTickStandardScreen(
          topBarTitle: 'Workout',
          pageTitle: pageTitle,
          pageTitleButtons: Row(
            mainAxisSize: MainAxisSize.min,
            children: pageTitleButtons,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          children: [
            Expanded(child: bodyContent),
          ],
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
              Counter(label: 'Amount', onChanged: (value) => print(value)),
              Counter(label: 'Rest', onChanged: (value) => print(value)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Divider(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Exercises', style: theme.textTheme.titleMedium),
              IconButton.filledTonal(
                icon: const Icon(Icons.add),
                onPressed: () => print('add'),
                style: IconButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                ),
                padding: const EdgeInsets.all(8),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              // ...exercises.map((exercise) => ExerciseCard(exercise: exercise)),
              WorkoutExerciseCard(
                exercise: Exercise(
                  id: '1',
                  name: 'Exercise 1',
                  description: 'Description 1',
                  exerciseTime: 10,
                  restTime: 10,
                ),
              ),
              WorkoutExerciseCard(
                exercise: Exercise(
                  id: '2',
                  name: 'Exercise 2',
                  description: 'Description 2',
                  exerciseTime: 10,
                  restTime: 10,
                ),
              ),
              WorkoutExerciseCard(
                exercise: Exercise(
                  id: '3',
                  name: 'Exercise 3',
                  description: 'Description 3',
                  exerciseTime: 10,
                  restTime: 10,
                ),
              ),
              WorkoutExerciseCard(
                exercise: Exercise(
                  id: '4',
                  name: 'Exercise 4',
                  description: 'Description 4',
                  exerciseTime: 10,
                  restTime: 10,
                ),
              ),
              WorkoutExerciseCard(
                exercise: Exercise(
                  id: '5',
                  name: 'Exercise 5',
                  description: 'Description 5',
                  exerciseTime: 10,
                  restTime: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
