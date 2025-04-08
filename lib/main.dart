import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fit_tick_mobile/core/di.dart';
import 'package:fit_tick_mobile/core/firebase_options.dart';
import 'package:fit_tick_mobile/features/home/home_screen.dart';
import 'package:fit_tick_mobile/features/workout/workout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'util.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ProviderScope(child: const FitTickApp()));
}

class FitTickApp extends StatelessWidget {
  const FitTickApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final authService = ref.watch(authServiceProvider);

        if (authService.currentUser == null) {
          authService.signInAnonymously();
        }

        final brightness =
            View.of(context).platformDispatcher.platformBrightness;
        TextTheme textTheme = createTextTheme(context, "Roboto", "Montserrat");
        MaterialTheme theme = MaterialTheme(textTheme);

        final homeBloc = ref.watch(homeBlocProvider);

        return MaterialApp(
          title: 'FitTick',
          theme: brightness == Brightness.light ? theme.light() : theme.dark(),
          home: BlocProvider.value(
            value: homeBloc,
            child: HomeScreen(),
          ),
          routes: {'/workout': (context) => const WorkoutScreen()},
        );
      },
    );
  }
}
