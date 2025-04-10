import 'package:fit_tick_mobile/ui/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_tick_mobile/features/exercise/exercise_bloc.dart';
import 'package:fit_tick_mobile/features/exercise/exercise_state.dart';
import 'package:fit_tick_mobile/ui/standard_screen.dart';
import 'package:fit_tick_mobile/ui/textfield.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final _nameController = TextEditingController();
  final _timeController = TextEditingController();
  final _label1Controller = TextEditingController();
  final _label2Controller = TextEditingController();
  final _label3Controller = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _timeController.dispose();
    _label1Controller.dispose();
    _label2Controller.dispose();
    _label3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseBloc, ExerciseState>(
      builder: (context, state) {
        return FitTickStandardScreen(
          topBarTitle: 'Exercise',
          pageTitle: 'Create Exercise',
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FitTickTextField(
                      controller: _nameController,
                      labelText: 'Exercise Name',
                    ),
                    const SizedBox(height: 16),
                    FitTickTextField(
                      controller: _timeController,
                      labelText: 'Description (optional)', // Placeholder
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Counter(
                            label: 'Exercise Time (sec)',
                            onChanged: (value) => print(value),
                          ),
                          Counter(
                            label: 'Rest Time (sec)',
                            onChanged: (value) => print(value),
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
                              // TODO: Dispatch save event
                              // final exerciseName = _nameController.text;
                              // context.read<ExerciseBloc>().add(SaveExerciseEvent(...));
                            },
                            child: const Text('Save'),
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
    );
  }
}
