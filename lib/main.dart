import 'package:firebase_core/firebase_core.dart';
import 'package:fit_tick_mobile/core/firebase_options.dart';
import 'package:fit_tick_mobile/features/home/home_screen.dart';
import 'package:fit_tick_mobile/features/workout/workout_screen.dart';
import 'package:flutter/material.dart';
import 'util.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const FitTickApp());
}

class FitTickApp extends StatelessWidget {
  const FitTickApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "Roboto", "Montserrat");

    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'FitTick',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: const HomeScreen(),
      routes: {'/workout': (context) => const WorkoutScreen()},
    );
  }
}
