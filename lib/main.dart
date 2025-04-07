import 'package:fit_tick_mobile/features/home/home_screen.dart';
import 'package:fit_tick_mobile/features/workout/workout_screen.dart';
import 'package:flutter/material.dart';
import 'util.dart';
import 'theme.dart';

void main() {
  runApp(const FitTickApp());
}

class FitTickApp extends StatelessWidget {
  const FitTickApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "Roboto", "Montserrat");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'FitTick',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: const HomeScreen(),
      routes: {
        '/workout': (context) => const WorkoutScreen(),
      },
    );
  }
}
