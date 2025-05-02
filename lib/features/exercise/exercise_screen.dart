import 'package:fit_tick_mobile/data/exercise/exercise.dart';
import 'package:fit_tick_mobile/ui/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_tick_mobile/features/exercise/exercise_bloc.dart';
import 'package:fit_tick_mobile/ui/standard_screen.dart';
import 'package:fit_tick_mobile/ui/textfield.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  int _exerciseTimeController = 0;
  int _restTimeController = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final workoutId = args?['workoutId'] as String?;
      final exerciseId = args?['exerciseId'] as String?;
      if (workoutId != null) {
        context.read<ExerciseBloc>().add(
          InitExercise(workoutId: workoutId, exerciseId: exerciseId),
        );
      } else {
        print("Error: workoutId is null");
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<ExerciseBloc, ExerciseState>(
      listener: (context, state) {
        if (state is ExerciseSaveSuccess) {
          Navigator.of(context).pop(true);
        }
        if (state is ExerciseLoaded && state.exercise != null) {
          _nameController.text = state.exercise!.name;
          _descriptionController.text = state.exercise!.description ?? '';
          _exerciseTimeController = state.exercise!.exerciseTime ?? 5;
          _restTimeController = state.exercise!.restTime ?? 0;
        }
      },
      child: BlocBuilder<ExerciseBloc, ExerciseState>(
        builder: (context, state) {
          return FitTickStandardScreen(
            topBarTitle: 'Exercise',
            pageTitle: 'Create Exercise',
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            children: [
              if (state is ExerciseInitial)
                const Center(child: CircularProgressIndicator())
              else if (state is ExerciseLoaded)
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FitTickTextField(
                          controller: _nameController,
                          labelText: 'Exercise Name',
                          textCapitalization: TextCapitalization.words,
                        ),
                        const SizedBox(height: 16),
                        FitTickTextField(
                          controller: _descriptionController,
                          labelText: 'Description (optional)',
                        ),
                        const SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Counter(
                                label: 'Exercise Time (sec)',
                                initialValue: state.exercise?.exerciseTime ?? 5,
                                minimumValue: 5,
                                onChanged:
                                    (value) => _exerciseTimeController = value,
                              ),
                              Counter(
                                label: 'Rest Time (sec)',
                                initialValue: state.exercise?.restTime ?? 0,
                                minimumValue: 0,
                                onChanged:
                                    (value) => _restTimeController = value,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Cancel'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: FilledButton(
                                onPressed: () {
                                  context.read<ExerciseBloc>().add(
                                    SaveExercise(
                                      workoutId: state.workoutId,
                                      exercise: Exercise(
                                        id: state.exercise?.id ?? '',
                                        name: _nameController.text,
                                        index: state.exercise?.index,
                                        description:
                                            _descriptionController.text,
                                        exerciseTime: _exerciseTimeController,
                                        restTime: _restTimeController,
                                      ),
                                    ),
                                  );
                                },
                                child:
                                    state.isSaving
                                        ? SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: theme.colorScheme.onSurface,
                                          ),
                                        )
                                        : const Text('Save'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
