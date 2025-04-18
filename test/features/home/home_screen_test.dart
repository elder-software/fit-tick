import 'package:fit_tick_mobile/data/auth/auth_service.dart';
import 'package:fit_tick_mobile/data/workout/workout.dart';
import 'package:fit_tick_mobile/data/workout/workout_repo.dart';
import 'package:fit_tick_mobile/features/home/home_bloc.dart';
import 'package:fit_tick_mobile/features/home/home_screen.dart';
import 'package:fit_tick_mobile/ui/card.dart';
import 'package:fit_tick_mobile/ui/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Generate mocks for HomeBloc
import 'home_screen_test.mocks.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

@GenerateNiceMocks([
  MockSpec<HomeBloc>(),
  MockSpec<AuthService>(),
  MockSpec<WorkoutRepo>(),
])
void main() {
  late MockHomeBloc mockHomeBloc;
  late NavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockHomeBloc = MockHomeBloc();
    mockNavigatorObserver = MockNavigatorObserver();
  });

  // Helper function to pump the HomeScreen widget
  Future<void> pumpHomeScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<HomeBloc>.value(
          value: mockHomeBloc,
          child: const HomeScreen(),
        ),
        navigatorObservers: [mockNavigatorObserver],
        // Define routes for navigation testing
        routes: {
          '/account': (context) => const Scaffold(body: Text('Account Screen')),
          '/workout': (context) => const Scaffold(body: Text('Workout Screen')),
        },
      ),
    );
  }

  // Sample workout data
  final workout1 = Workout(id: '1', userId: 'user1', name: 'Workout A');
  final workout2 = Workout(id: '2', userId: 'user1', name: 'Workout B');
  final List<Workout> mockWorkouts = [workout1, workout2];

  testWidgets('initial state triggers LoadWorkouts', (
    WidgetTester tester,
  ) async {
    final verifyBloc = MockHomeBloc();

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<HomeBloc>.value(
          value: verifyBloc,
          child: const HomeScreen(),
        ),
      ),
    );
    await tester.pump();
    verify(verifyBloc.add(LoadWorkouts())).called(1);
    verifyBloc.close();
  });

  testWidgets('displays CircularProgressIndicator when loading', (
    WidgetTester tester,
  ) async {
    when(
      mockHomeBloc.stream,
    ).thenAnswer((_) => Stream.fromIterable([HomeLoading()]));
    await pumpHomeScreen(tester);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('displays message when no workouts are loaded', (
    WidgetTester tester,
  ) async {
    when(
      mockHomeBloc.stream,
    ).thenAnswer((_) => Stream.fromIterable([const HomeLoaded(workouts: [])]));

    await pumpHomeScreen(tester);
    await tester.pump();

    expect(find.text('No workouts yet. Add one!'), findsOneWidget);
  });

  testWidgets('displays list of workouts when loaded', (
    WidgetTester tester,
  ) async {
    when(mockHomeBloc.stream).thenAnswer(
      (_) => Stream.fromIterable([HomeLoaded(workouts: mockWorkouts)]),
    );

    await pumpHomeScreen(tester);
    await tester.pump();

    expect(find.byType(ListView), findsOneWidget);
    expect(
      find.byType(FitTickStandardCard),
      findsNWidgets(mockWorkouts.length),
    );
    expect(find.text(workout1.name), findsOneWidget);
    expect(find.text(workout2.name), findsOneWidget);
  });

  testWidgets('displays error message on error state', (
    WidgetTester tester,
  ) async {
    const errorMessage = 'Failed to load workouts';
    when(mockHomeBloc.stream).thenAnswer(
      (_) => Stream.fromIterable([const HomeError(message: errorMessage)]),
    );

    await pumpHomeScreen(tester);
    await tester.pump();

    expect(find.text('Error: $errorMessage'), findsOneWidget);
  });

  testWidgets('navigates to account screen when account icon is tapped', (
    WidgetTester tester,
  ) async {
    when(
      mockHomeBloc.stream,
    ).thenAnswer((_) => Stream.fromIterable([const HomeLoaded(workouts: [])]));

    await pumpHomeScreen(tester);
    await tester.pump();

    await tester.tap(find.byIcon(Icons.account_circle_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Account Screen'), findsOneWidget);
  });

  testWidgets('navigates to workout screen when workout card is tapped', (
    WidgetTester tester,
  ) async {
    when(mockHomeBloc.stream).thenAnswer(
      (_) => Stream.fromIterable([HomeLoaded(workouts: mockWorkouts)]),
    );

    await pumpHomeScreen(tester);
    await tester.pump();

    await tester.tap(find.text(workout1.name));
    await tester.pumpAndSettle();

    expect(find.text('Workout Screen'), findsOneWidget);
  });

  testWidgets('shows add workout dialog when add button is tapped', (
    WidgetTester tester,
  ) async {
    when(
      mockHomeBloc.stream,
    ).thenAnswer((_) => Stream.fromIterable([const HomeLoaded(workouts: [])]));

    await pumpHomeScreen(tester);
    await tester.pump(); // Let state settle

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle(); // Wait for dialog animation

    expect(find.byType(StandardDialog), findsOneWidget);
    expect(find.text('Workout Name'), findsOneWidget);
  });

  testWidgets('calls CreateWorkout when add workout dialog is confirmed', (
    WidgetTester tester,
  ) async {
    when(
      mockHomeBloc.stream,
    ).thenAnswer((_) => Stream.fromIterable([const HomeLoaded(workouts: [])]));

    await pumpHomeScreen(tester);
    await tester.pump();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    const newWorkoutName = 'New Cardio';
    await tester.enterText(find.byType(TextField), newWorkoutName);
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();

    verify(mockHomeBloc.add(CreateWorkout(name: newWorkoutName))).called(1);
    expect(find.byType(StandardDialog), findsNothing);
  });

  testWidgets('shows workout options bottom sheet when more button is tapped', (
    WidgetTester tester,
  ) async {
    when(mockHomeBloc.stream).thenAnswer(
      (_) => Stream.fromIterable([HomeLoaded(workouts: mockWorkouts)]),
    );

    await pumpHomeScreen(tester);
    await tester.pump();

    final moreButtonFinder = find.descendant(
      of: find.widgetWithText(FitTickStandardCard, workout1.name),
      matching: find.byIcon(Icons.more_vert),
    );

    expect(moreButtonFinder, findsOneWidget);
    await tester.tap(moreButtonFinder);
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsOneWidget);
    expect(find.text('Edit'), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);
  });

  testWidgets('shows edit workout dialog when Edit is tapped in bottom sheet', (
    WidgetTester tester,
  ) async {
    when(mockHomeBloc.stream).thenAnswer(
      (_) => Stream.fromIterable([HomeLoaded(workouts: mockWorkouts)]),
    );

    await pumpHomeScreen(tester);
    await tester.pump();

    // Tap more button on the first workout
    final moreButtonFinder = find.descendant(
      of: find.widgetWithText(FitTickStandardCard, workout1.name),
      matching: find.byIcon(Icons.more_vert),
    );
    await tester.tap(moreButtonFinder);
    await tester.pumpAndSettle();

    // Tap Edit in the bottom sheet
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();

    // Verify dialog appears
    expect(find.byType(StandardDialog), findsOneWidget);
    expect(find.text('Workout Name'), findsOneWidget);
    // Verify the text field is pre-filled
    expect(find.widgetWithText(TextField, workout1.name), findsOneWidget);
  });

  testWidgets('calls UpdateWorkout when edit dialog is confirmed', (
    WidgetTester tester,
  ) async {
    when(mockHomeBloc.stream).thenAnswer(
      (_) => Stream.fromIterable([HomeLoaded(workouts: mockWorkouts)]),
    );

    await pumpHomeScreen(tester);
    await tester.pump();

    // Open bottom sheet -> Tap Edit
    await tester.tap(
      find.descendant(
        of: find.widgetWithText(FitTickStandardCard, workout1.name),
        matching: find.byIcon(Icons.more_vert),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();

    // Edit text and confirm
    const updatedName = 'Workout A Updated';
    await tester.enterText(find.byType(TextField), updatedName);
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();

    // Verify UpdateWorkout was called with a workout that has the updated name
    verify(
      mockHomeBloc.add(
        argThat(
          isA<UpdateWorkout>().having(
            (event) => event.workout.name,
            'workout name',
            equals(updatedName),
          ),
        ),
      ),
    ).called(1);
    expect(find.byType(StandardDialog), findsNothing);
  });

  testWidgets('shows delete confirmation dialog when Delete is tapped', (
    WidgetTester tester,
  ) async {
    when(mockHomeBloc.stream).thenAnswer(
      (_) => Stream.fromIterable([HomeLoaded(workouts: mockWorkouts)]),
    );

    await pumpHomeScreen(tester);
    await tester.pump();

    // Open bottom sheet -> Tap Delete
    await tester.tap(
      find.descendant(
        of: find.widgetWithText(FitTickStandardCard, workout1.name),
        matching: find.byIcon(Icons.more_vert),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    // Verify delete confirmation dialog appears
    expect(find.byType(StandardDialog), findsOneWidget);
    expect(find.text('Delete Workout'), findsOneWidget);
    expect(
      find.text('Are you sure you want to delete this workout?'),
      findsOneWidget,
    );
  });

  testWidgets('calls DeleteWorkout when delete dialog is confirmed', (
    WidgetTester tester,
  ) async {
    when(mockHomeBloc.stream).thenAnswer(
      (_) => Stream.fromIterable([HomeLoaded(workouts: mockWorkouts)]),
    );

    await pumpHomeScreen(tester);
    await tester.pump();

    // Open bottom sheet -> Tap Delete -> Tap Confirm
    await tester.tap(
      find.descendant(
        of: find.widgetWithText(FitTickStandardCard, workout1.name),
        matching: find.byIcon(Icons.more_vert),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Confirm')); // Confirm deletion
    await tester.pumpAndSettle();

    // Verify DeleteWorkout was called
    verify(mockHomeBloc.add(DeleteWorkout(workoutId: workout1.id))).called(1);
    expect(find.byType(StandardDialog), findsNothing);
  });
}
