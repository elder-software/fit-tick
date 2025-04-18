import 'package:fit_tick_mobile/data/exercise/exercise.dart';
import 'package:fit_tick_mobile/data/workout/workout.dart';
import 'package:fit_tick_mobile/features/workout/workout_bloc.dart';
import 'package:fit_tick_mobile/features/workout/workout_exercise_card.dart';
import 'package:fit_tick_mobile/ui/counter.dart';
import 'package:fit_tick_mobile/ui/fab.dart';
import 'package:fit_tick_mobile/ui/icon.dart';
import 'package:fit_tick_mobile/ui/standard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fit_tick_mobile/ui/dialog.dart';
import 'package:fit_tick_mobile/ui/textfield.dart';

class WorkoutScreen extends ConsumerStatefulWidget {
  const WorkoutScreen({super.key});

  @override
  ConsumerState<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends ConsumerState<WorkoutScreen> {
  int _roundAmount = 1; // Default to 1 round
  int _roundRest = 0; // Default to 60 seconds rest

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
          const ShowTransientError(message: 'Could not load workout'),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkoutBloc, WorkoutState>(
      listener: (context, state) {
        if (state is WorkoutLoaded && state.transientErrorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.transientErrorMessage!)));
        }
      },
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
                  () => _showEditDeleteBottomSheet(
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
                        workoutBloc.add(DeleteWorkout(workoutId: workout.id));
                        Navigator.of(context).pop();
                      });
                    },
                  ),
            ),
          ];
          bodyContent = WorkoutLoadedWidget(
            workout: workout,
            exercises: state.exercises,
            exercisesLoading: state.exercisesLoading,
            onRoundAmountChanged: (value) {
              setState(() {
                _roundAmount = value;
              });
            },
            onRoundRestChanged: (value) {
              setState(() {
                _roundRest = value;
              });
            },
            onMoreOptionsPressed: (exercise) {
              _showEditDeleteBottomSheet(
                context,
                exercise.name.isNotEmpty ? exercise.name : 'Exercise',
                onEdit: () async {
                  final result = await Navigator.of(context).pushNamed(
                    '/exercise',
                    arguments: {
                      'workoutId': workout.id,
                      'exerciseId': exercise.id,
                    },
                  );
                  if (!context.mounted) return;
                  if (result == true) {
                    context.read<WorkoutBloc>().add(
                      LoadExercises(workoutId: workout.id, workout: workout),
                    );
                  }
                },
                onDelete: () {
                  workoutBloc.add(
                    DeleteExercise(
                      workoutId: workout.id,
                      exerciseId: exercise.id,
                    ),
                  );
                },
              );
            },
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
          floatingActionButtonLocation:
              const CenterUpFloatingActionButtonLocation(24.0),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (state is! WorkoutLoaded) return;

              if (state.exercises.isEmpty) {
                context.read<WorkoutBloc>().add(
                  const ShowTransientError(message: 'No exercises to start'),
                );
                return;
              }
              final timerExercises = buildTimerExercises(
                state.exercises,
                _roundAmount,
                _roundRest,
              );

              Navigator.of(
                context,
              ).pushNamed('/timer', arguments: {'exercises': timerExercises});
            },
            child: const Icon(Icons.play_arrow),
          ),
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

  void _showEditDeleteBottomSheet(
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
              title: const Text('Edit'),
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
            textCapitalization: TextCapitalization.words,
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
  final bool exercisesLoading;
  final Function(Exercise) onMoreOptionsPressed;
  final Function(int) onRoundAmountChanged;
  final Function(int) onRoundRestChanged;

  const WorkoutLoadedWidget({
    super.key,
    required this.workout,
    required this.exercises,
    required this.exercisesLoading,
    required this.onMoreOptionsPressed,
    required this.onRoundAmountChanged,
    required this.onRoundRestChanged,
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
              Counter(
                label: 'Amount',
                onChanged: (value) => onRoundAmountChanged(value),
              ),
              Counter(
                label: 'Rest',
                onChanged: (value) => onRoundRestChanged(value),
              ),
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
              IconButton.outlined(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  final result = await Navigator.pushNamed(
                    context,
                    '/exercise',
                    arguments: {'workoutId': workout.id},
                  );
                  if (result == true) {
                    if (!context.mounted) return;
                    context.read<WorkoutBloc>().add(
                      LoadExercises(workoutId: workout.id, workout: workout),
                    );
                  }
                },
                padding: const EdgeInsets.all(8),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              if (exercisesLoading)
                const Center(child: CircularProgressIndicator())
              else
                ...exercises.map(
                  (exercise) => WorkoutExerciseCard(
                    exercise: exercise,
                    onMoreOptionsPressed: () => onMoreOptionsPressed(exercise),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
