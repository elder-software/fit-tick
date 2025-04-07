import 'package:fit_tick_mobile/ui/textfield.dart';
import 'package:flutter/material.dart';
import 'package:fit_tick_mobile/ui/dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text('Workouts', style: theme.textTheme.headlineSmall),
          const Divider(height: 32.0),
          // TODO: Add Workout List Items here
          _buildWorkoutCard(
            context: context,
            title: 'Morning Routine',
            details: '28:00 - 7 rounds',
            onTap: () {
              Navigator.pushNamed(context, '/workout');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddWorkoutDialog(context);
        },
        backgroundColor: colorScheme.tertiaryContainer,
        foregroundColor: colorScheme.onTertiaryContainer,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddWorkoutDialog(BuildContext context) async {
    final TextEditingController controller = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StandardDialog(
          title: 'Workout Name',
          content: _buildAddWorkoutDialogContent(controller, dialogContext),
          onSave: () {
            String workoutName = controller.text;
            if (workoutName.isNotEmpty) {
              print('Workout Name Entered: $workoutName');
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

  Widget _buildAddWorkoutDialogContent(
    TextEditingController controller,
    BuildContext context,
  ) {
    return SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          FitTickTextField(controller: controller, labelText: 'Workout Name'),
        ],
      ),
    );
  }

  Widget _buildWorkoutCard({
    required BuildContext context,
    required String title,
    required String details,
    required Function() onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
        color: colorScheme.surface, // Or surfaceContainerHighest etc.
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  color:
                      colorScheme.primary, // Using primary for the title color
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                details,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
