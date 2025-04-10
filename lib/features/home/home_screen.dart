import 'package:fit_tick_mobile/ui/fab.dart';
import 'package:fit_tick_mobile/ui/standard_screen.dart';
import 'package:fit_tick_mobile/ui/textfield.dart';
import 'package:flutter/material.dart';
import 'package:fit_tick_mobile/ui/dialog.dart';
import 'package:fit_tick_mobile/features/home/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_tick_mobile/ui/card.dart';
import 'package:fit_tick_mobile/data/workout/workout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadWorkouts());
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();

    return FitTickStandardScreen(
      topBarTitle: 'Home',
      pageTitle: 'Workouts',
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          // TODO: Implement drawer or menu action
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.account_circle_outlined),
          onPressed: () {
            // TODO: Implement account action
          },
        ),
      ],
      floatingActionButtonLocation: const CenterUpFloatingActionButtonLocation(
        24.0,
      ),
      floatingActionButton: StandardFloatingActionButton(
        icon: Icons.add,
        onPressed: () {
          _showWorkoutNameDialog(context, null, (String name) {
            homeBloc.add(CreateWorkout(name: name));
          });
        },
      ),
      children: [
        Expanded(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeInitial || state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is HomeLoaded) {
                if (state.workouts.isEmpty) {
                  return const Center(child: Text('No workouts yet. Add one!'));
                }
                return ListView.builder(
                  itemCount: state.workouts.length,
                  itemBuilder: (context, index) {
                    final workout = state.workouts[index];
                    return FitTickStandardCard(
                      title: workout.name,
                      details: workout.id,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/workout',
                          arguments: {'workoutId': workout.id},
                        );
                      },
                      onTapMore:
                          () => {
                            _showWorkoutOptionsBottomSheet(
                              context,
                              workout.name,
                              onEdit: () {
                                _showWorkoutNameDialog(context, workout.name, (
                                  String name,
                                ) {
                                  homeBloc.add(
                                    UpdateWorkout(
                                      workout: Workout(
                                        id: workout.id,
                                        userId: workout.userId,
                                        name: name,
                                      ),
                                    ),
                                  );
                                });
                              },
                              onDelete: () {
                                _showDeleteWorkoutDialog(
                                  context,
                                  workout.name,
                                  () {
                                    homeBloc.add(
                                      DeleteWorkout(workoutId: workout.id),
                                    );
                                  },
                                );
                              },
                            ),
                          },
                    );
                  },
                );
              }
              if (state is HomeError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const Center(child: Text('Something went wrong.'));
            },
          ),
        ),
      ],
    );
  }

  void _showWorkoutOptionsBottomSheet(
    BuildContext context,
    String title, {
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext ctx) {
        return Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 16.0),
              child: Text(title, style: Theme.of(context).textTheme.titleLarge),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit'),
              onTap: () {
                Navigator.pop(ctx); // Close the bottom sheet
                onEdit(); // Call the provided callback
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                Navigator.pop(ctx); // Close the bottom sheet
                onDelete(); // Call the provided callback
              },
            ),
            const SizedBox(height: 120.0), // Use existing increased padding
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
        // Pass the controller and use the correct context for ScaffoldMessenger
        return StandardDialog(
          title: 'Workout Name',
          content: FitTickTextField(
            controller: controller,
            capitalizeWords: true,
          ),
          onConfirm: () {
            String workoutName = controller.text;
            if (workoutName.isNotEmpty) {
              onConfirm(workoutName);
              Navigator.of(dialogContext).pop(); // Close the dialog on success
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
          content: Text('Are you sure you want to delete this workout?'),
          onConfirm: () {
            Navigator.of(dialogContext).pop();
            onConfirm();
          },
        );
      },
    );
  }
}
