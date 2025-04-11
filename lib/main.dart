import 'package:firebase_core/firebase_core.dart';
import 'package:fit_tick_mobile/features/timer/timer_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fit_tick_mobile/core/di.dart';
import 'package:fit_tick_mobile/core/firebase_options.dart';
import 'package:fit_tick_mobile/features/home/home_screen.dart';
import 'package:fit_tick_mobile/features/workout/workout_screen.dart';
import 'package:fit_tick_mobile/features/exercise/exercise_screen.dart';
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
        final workoutBloc = ref.watch(workoutBlocProvider);
        final exerciseBloc = ref.watch(exerciseBlocProvider);

        return MaterialApp(
          title: 'FitTick',
          theme: brightness == Brightness.light ? theme.light() : theme.dark(),
          home: BlocProvider.value(value: homeBloc, child: HomeScreen()),
          routes: {
            '/workout': (context) {
              return BlocProvider.value(
                value: workoutBloc,
                child: WorkoutScreen(),
              );
            },
            '/exercise': (context) {
              return BlocProvider.value(
                value: exerciseBloc,
                child: const ExerciseScreen(),
              );
            },
          },
          onGenerateRoute: (settings) {
            if (settings.name == '/timer') {
              return PageRouteBuilder(
                settings: settings,
                pageBuilder:
                    (context, animation, secondaryAnimation) =>
                        BlocProvider.value(
                          value: ref.read(timerBlocProvider),
                          child: const TimerScreen(),
                        ),
                transitionsBuilder: (
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                ) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(parent: animation, curve: Curves.easeOut),
                    ),
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 300),
              );
            }
            return null;
          },
        );
      },
    );
  }
}
