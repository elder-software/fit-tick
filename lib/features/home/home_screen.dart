import 'package:fit_tick_mobile/ui/fab.dart';
import 'package:fit_tick_mobile/ui/textfield.dart';
import 'package:flutter/material.dart';
import 'package:fit_tick_mobile/ui/dialog.dart';
import 'package:fit_tick_mobile/features/home/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_tick_mobile/ui/card.dart';

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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // TODO: Implement drawer or menu action
          },
        ),
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {
              // TODO: Implement account action
            },
          ),
        ],
      ),
      body: Padding(
        // Use Padding instead of ListView if the content might be small
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Workouts', style: theme.textTheme.headlineSmall),
            const Divider(height: 32.0),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeInitial || state is HomeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is HomeLoaded) {
                    if (state.workouts.isEmpty) {
                      return const Center(
                        child: Text('No workouts yet. Add one!'),
                      );
                    }
                    return ListView.builder(
                      itemCount: state.workouts.length,
                      itemBuilder: (context, index) {
                        final workout = state.workouts[index];
                        return FitTickStandardCard(
                          title: workout.name,
                          details: workout.id ?? 'No ID',
                          onTap: () {},
                          onTapMore: () => {},
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
        ),
      ),
      floatingActionButtonLocation: const CenterUpFloatingActionButtonLocation(
        24.0,
      ),
      floatingActionButton: StandardFloatingActionButton(
        icon: Icons.add,
        onPressed: () {
          _showAddWorkoutDialog(context, context.read<HomeBloc>());
        },
      ),
    );
  }

  Future<void> _showAddWorkoutDialog(
    BuildContext context,
    HomeBloc homeBloc,
  ) async {
    final TextEditingController controller = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        // Pass the controller and use the correct context for ScaffoldMessenger
        return StandardDialog(
          title: 'Workout Name',
          content: _buildAddWorkoutDialogContent(controller),
          onSave: () {
            String workoutName = controller.text;
            if (workoutName.isNotEmpty) {
              // Add event to the bloc instance
              homeBloc.add(CreateWorkout(name: workoutName));
              Navigator.of(dialogContext).pop(); // Close the dialog on success
            } else {
              // Show SnackBar using the dialog's context
              ScaffoldMessenger.of(dialogContext).showSnackBar(
                const SnackBar(content: Text('Workout name cannot be empty')),
              );
            }
          },
        );
      },
    );
  }

  Widget _buildAddWorkoutDialogContent(TextEditingController controller) {
    return SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          FitTickTextField(controller: controller, labelText: 'Workout Name'),
        ],
      ),
    );
  }
}
