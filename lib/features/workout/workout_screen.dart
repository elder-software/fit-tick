import 'package:fit_tick_mobile/data/exercise/exercise.dart';
import 'package:fit_tick_mobile/data/workout/workout.dart';
import 'package:fit_tick_mobile/features/workout/workout_bloc.dart';
import 'package:fit_tick_mobile/features/workout/workout_exercise_card.dart';
import 'package:fit_tick_mobile/ui/counter.dart';
import 'package:fit_tick_mobile/ui/icon.dart';
import 'package:fit_tick_mobile/ui/standard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_tick_mobile/ui/dialog.dart';
import 'package:fit_tick_mobile/ui/textfield.dart';

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
        final workoutBloc = context.read<WorkoutBloc>();

        if (state is WorkoutLoaded) {
          final workout = state.workout;
          pageTitle = workout.name;
          pageTitleButtons = [
            StyledIconButton(
              icon: Icons.more_vert,
              showBorder: false,
              onPressed:
                  () => _showWorkoutOptionsBottomSheet(
                    context,
                    workout.name,
                    onEdit: () {
                      _showWorkoutNameDialog(context, workout.name, (
                        String name,
                      ) {
                        workoutBloc.add(
                          UpdateWorkout(workout: workout.copyWith(name: name)),
                        );
                      });
                    },
                    onDelete: () {
                      _showDeleteWorkoutDialog(context, workout.name, () {
                        workoutBloc.add(
                          DeleteWorkout(workoutId: workout.id ?? ''),
                        );
                        Navigator.of(context).pop();
                      });
                    },
                  ),
            ),
          ];
          bodyContent = WorkoutLoadedWidget(
            workout: workout,
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
          children: [Expanded(child: bodyContent)],
        );
      },
    );
  }

  void _showWorkoutOptionsBottomSheet(
    BuildContext context,
    String workoutName, {
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext ctx) {
        return Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                workoutName,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Name'),
              onTap: () {
                Navigator.pop(ctx);
                onEdit();
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                Navigator.pop(ctx);
                onDelete();
              },
            ),
            const SizedBox(height: 128),
          ],
        );
      },
    );
  }

  Future<void> _showWorkoutNameDialog(
    BuildContext context,
    String? workoutName,
    Function(String) onConfirm,
  ) async {
    final TextEditingController controller = TextEditingController();
    controller.text = workoutName ?? '';

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StandardDialog(
          title: 'Edit Workout Name',
          content: FitTickTextField(
            controller: controller,
            labelText: 'Workout Name',
          ),
          onConfirm: () {
            String newWorkoutName = controller.text;
            if (newWorkoutName.isNotEmpty) {
              onConfirm(newWorkoutName);
              Navigator.of(dialogContext).pop();
            } else {
              ScaffoldMessenger.of(dialogContext).showSnackBar(
                const SnackBar(content: Text('Workout name cannot be empty')),
              );
            }
          },
        );
      },
    );
  }

  Future<void> _showDeleteWorkoutDialog(
    BuildContext context,
    String workoutName,
    VoidCallback onConfirm,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StandardDialog(
          title: 'Delete Workout',
          content: Text('Are you sure you want to delete "$workoutName"?'),
          onConfirm: () {
            Navigator.of(dialogContext).pop();
            onConfirm();
          },
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
