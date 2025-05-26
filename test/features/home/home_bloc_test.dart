import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tick_mobile/data/auth/auth_service.dart';
import 'package:fit_tick_mobile/data/workout/workout.dart';
import 'package:fit_tick_mobile/data/workout/workout_repo.dart';
import 'package:fit_tick_mobile/features/home/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'dart:async';

import 'home_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthService>(),
  MockSpec<WorkoutRepo>(),
  MockSpec<User>(),
])
void main() {
  late MockAuthService mockAuthService;
  late MockWorkoutRepo mockWorkoutRepo;
  late HomeBloc homeBloc;
  late MockUser mockUser;

  // Define a constant for the user ID
  const testUserId = 'test_user_id';

  // Sample workout data using the constant ID
  final workout1 = Workout(id: 'w1', userId: testUserId, name: 'Workout A');
  final workout2 = Workout(id: 'w2', userId: testUserId, name: 'Workout B');
  final mockWorkouts = [workout1, workout2];
  final testException = Exception('Something went wrong');

  setUp(() {
    mockAuthService = MockAuthService();
    mockWorkoutRepo = MockWorkoutRepo();
    mockUser = MockUser();

    // Default setup: User is logged in
    when(mockAuthService.currentUser).thenReturn(mockUser);
    // Stub the uid getter for the mock User
    when(mockUser.uid).thenReturn(testUserId);

    // Initialize the bloc for each test
    homeBloc = HomeBloc(
      authService: mockAuthService,
      workoutRepo: mockWorkoutRepo,
    );
  });

  tearDown(() {
    homeBloc.close(); // Ensure bloc is closed after each test
  });

  group('HomeBloc', () {
    test('initial state is HomeInitial', () {
      // Assert
      expect(homeBloc.state, HomeInitial());
    });

    group('LoadWorkouts Event', () {
      // Declare controller here to be accessible in setUp and act
      late StreamController<List<Workout>> controller;

      blocTest<HomeBloc, HomeState>(
        'emits [HomeLoaded(workouts: [])] when user is null',
        // Arrange
        setUp: () {
          when(mockAuthService.currentUser).thenReturn(null);
        },
        build: () => homeBloc,
        act: (bloc) => bloc.add(LoadWorkouts()),
        expect: () => [const HomeLoaded(workouts: [])],
        verify: (_) {
          verify(mockAuthService.currentUser).called(1);
          // Ensure workout repo is never called if user is null
          verifyNever(mockWorkoutRepo.allWorkoutsForUser(any));
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits [HomeLoading, HomeLoaded] when workouts are loaded successfully',
        setUp: () {
          when(
            mockWorkoutRepo.allWorkoutsForUser(testUserId),
          ).thenAnswer((_) => Stream.fromIterable([mockWorkouts]));
        },
        build: () => homeBloc,
        act: (bloc) => bloc.add(LoadWorkouts()),
        expect: () => [HomeLoading(), HomeLoaded(workouts: mockWorkouts)],
        verify: (_) {
          verify(mockAuthService.currentUser).called(1);
          verify(mockWorkoutRepo.allWorkoutsForUser(testUserId)).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits [HomeLoading, HomeLoaded] with subsequent updates from stream',
        // Arrange
        setUp: () {
          // Initialize the controller declared outside
          controller = StreamController<List<Workout>>();
          when(
            mockWorkoutRepo.allWorkoutsForUser(testUserId),
          ).thenAnswer((_) => controller.stream);
        },
        build: () => homeBloc,
        // Act: Add LoadWorkouts, then push data to the controller
        act: (bloc) async {
          bloc.add(LoadWorkouts());
          await pumpEventQueue(); // Allow BLoC to subscribe

          // Now add data to the controller
          controller.add(mockWorkouts);
          await pumpEventQueue(); // Let BLoC process the first update

          controller.add([workout1]);
          await pumpEventQueue(); // Let BLoC process the second update

          await controller.close();
          await pumpEventQueue(); // Allow close to process
        },
        expect:
            () => [
              HomeLoading(),
              HomeLoaded(workouts: mockWorkouts),
              HomeLoaded(workouts: [workout1]),
            ],
        verify: (_) {
          verify(mockWorkoutRepo.allWorkoutsForUser(testUserId)).called(1);
        },
        // Add wait duration to allow async stream updates
        wait: const Duration(milliseconds: 100),
      );

      blocTest<HomeBloc, HomeState>(
        'emits [HomeLoading, HomeError] when workout stream emits an error',
        // Arrange
        setUp: () {
          // Mock the repo to return a stream that emits an error
          when(
            mockWorkoutRepo.allWorkoutsForUser(testUserId),
          ).thenAnswer((_) => Stream.error(testException));
        },
        build: () => homeBloc,
        // Act
        act: (bloc) async {
          bloc.add(LoadWorkouts());
          await pumpEventQueue(); // Allow BLoC to subscribe
        },
        // Assert
        expect:
            () => [
              HomeLoading(), // Expect loading state
              // Expect error state with the correct message
              HomeError(message: 'Failed to load workouts: $testException'),
            ],
        verify: (_) {
          verify(mockWorkoutRepo.allWorkoutsForUser(testUserId)).called(1);
        },
      );
    });

    group('CreateWorkout Event', () {
      const newWorkoutName = 'New Workout';
      // Matcher for the workout object passed to createWorkout using the constant ID
      final workoutMatcher = isA<Workout>()
          .having((w) => w.name, 'name', newWorkoutName)
          .having((w) => w.userId, 'userId', testUserId) // Use the constant ID
          .having((w) => w.id, 'id', isEmpty); // ID should be empty initially

      blocTest<HomeBloc, HomeState>(
        'emits [HomeError] when user is null',
        // Arrange
        setUp: () {
          when(mockAuthService.currentUser).thenReturn(null);
        },
        build: () => homeBloc,
        // Act
        act: (bloc) => bloc.add(CreateWorkout(name: newWorkoutName)),
        // Assert
        expect:
            () => [
              const HomeError(
                message: 'Cannot create workout: User not logged in',
              ),
            ],
        verify: (_) {
          verify(mockAuthService.currentUser).called(1);
          // Ensure repo method is never called
          verifyNever(mockWorkoutRepo.createWorkout(any));
        },
      );

      blocTest<HomeBloc, HomeState>(
        'calls workoutRepo.createWorkout successfully',
        // Arrange
        setUp: () {
          // Mock successful creation
          when(
            mockWorkoutRepo.createWorkout(any),
          ).thenAnswer((_) async => Future.value());
          // Mock the stream to prevent hanging, but don't test the LoadWorkouts behavior
          when(
            mockWorkoutRepo.allWorkoutsForUser(mockUser.uid),
          ).thenAnswer((_) => const Stream.empty());
        },
        build: () => homeBloc,
        // Act
        act: (bloc) => bloc.add(CreateWorkout(name: newWorkoutName)),
        // Assert
        // Just verify the repository method was called, don't test LoadWorkouts side effect
        expect: () => [isA<HomeLoading>()], // Use matcher instead of concrete state
        verify: (_) {
          // currentUser is called in both CreateWorkout and LoadWorkouts handlers
          verify(mockAuthService.currentUser).called(2);
          // Verify createWorkout was called once with the correct workout data
          verify(
            mockWorkoutRepo.createWorkout(argThat(workoutMatcher)),
          ).called(1);
        },
        wait: const Duration(milliseconds: 100), // Wait for async operations
      );

      blocTest<HomeBloc, HomeState>(
        'emits [HomeError] when workoutRepo.createWorkout fails',
        // Arrange
        setUp: () {
          // Mock creation failure
          when(mockWorkoutRepo.createWorkout(any)).thenThrow(testException);
          // Mock workout stream needed for initial state setup if needed
          when(
            mockWorkoutRepo.allWorkoutsForUser(mockUser.uid),
          ).thenAnswer((_) => Stream.value(mockWorkouts));
        },
        build: () => homeBloc,
        // Act
        act: (bloc) async {
          // Optional: Load initial state
          // bloc.add(LoadWorkouts());
          // await pumpEventQueue();
          bloc.add(CreateWorkout(name: newWorkoutName));
        },
        // Assert
        expect:
            () => [
              // Optional states if LoadWorkouts was called first
              // HomeLoading(),
              // HomeLoaded(workouts: mockWorkouts),
              HomeError(message: 'Failed to create workout: $testException'),
            ],
        verify: (_) {
          verify(mockAuthService.currentUser).called(1);
          verify(
            mockWorkoutRepo.createWorkout(argThat(workoutMatcher)),
          ).called(1);
        },
      );
    });

    group('DeleteWorkout Event', () {
      final workoutIdToDelete = workout1.id;

      blocTest<HomeBloc, HomeState>(
        'calls workoutRepo.deleteWorkout successfully (no state change expected)',
        // Arrange
        setUp: () {
          // Mock successful deletion
          when(
            mockWorkoutRepo.deleteWorkout(workoutIdToDelete),
          ).thenAnswer((_) async => Future.value());
          // Mock workout stream needed for initial state setup if needed
          when(
            mockWorkoutRepo.allWorkoutsForUser(mockUser.uid),
          ).thenAnswer((_) => Stream.value(mockWorkouts));
        },
        build: () => homeBloc,
        // Act
        act: (bloc) async {
          // Optional: Load initial state
          // bloc.add(LoadWorkouts());
          // await pumpEventQueue();
          bloc.add(DeleteWorkout(workoutId: workoutIdToDelete));
        },
        // Assert
        expect: () => [], // No state change expected on success
        verify: (_) {
          verify(mockWorkoutRepo.deleteWorkout(workoutIdToDelete)).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits [HomeError] when workoutRepo.deleteWorkout fails',
        // Arrange
        setUp: () {
          // Mock deletion failure
          when(
            mockWorkoutRepo.deleteWorkout(workoutIdToDelete),
          ).thenThrow(testException);
          // Mock workout stream needed for initial state setup if needed
          when(
            mockWorkoutRepo.allWorkoutsForUser(mockUser.uid),
          ).thenAnswer((_) => Stream.value(mockWorkouts));
        },
        build: () => homeBloc,
        // Act
        act: (bloc) async {
          // Optional: Load initial state
          // bloc.add(LoadWorkouts());
          // await pumpEventQueue();
          bloc.add(DeleteWorkout(workoutId: workoutIdToDelete));
        },
        // Assert
        expect:
            () => [
              // Optional states if LoadWorkouts was called first
              // HomeLoading(),
              // HomeLoaded(workouts: mockWorkouts),
              HomeError(message: 'Failed to delete workout: $testException'),
            ],
        verify: (_) {
          verify(mockWorkoutRepo.deleteWorkout(workoutIdToDelete)).called(1);
        },
      );
    });

    group('UpdateWorkout Event', () {
      final workoutToUpdate = workout1.copyWith(name: 'Updated Workout A');

      blocTest<HomeBloc, HomeState>(
        'calls workoutRepo.updateWorkout successfully (no state change expected)',
        // Arrange
        setUp: () {
          // Mock successful update
          when(
            mockWorkoutRepo.updateWorkout(workoutToUpdate),
          ).thenAnswer((_) async => Future.value());
          // Mock workout stream needed for initial state setup if needed
          when(
            mockWorkoutRepo.allWorkoutsForUser(mockUser.uid),
          ).thenAnswer((_) => Stream.value(mockWorkouts));
        },
        build: () => homeBloc,
        // Act
        act: (bloc) async {
          // Optional: Load initial state
          // bloc.add(LoadWorkouts());
          // await pumpEventQueue();
          bloc.add(UpdateWorkout(workout: workoutToUpdate));
        },
        // Assert
        expect: () => [], // No state change expected on success
        verify: (_) {
          verify(mockWorkoutRepo.updateWorkout(workoutToUpdate)).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits [HomeError] when workoutRepo.updateWorkout fails',
        // Arrange
        setUp: () {
          // Mock update failure
          when(
            mockWorkoutRepo.updateWorkout(workoutToUpdate),
          ).thenThrow(testException);
          // Mock workout stream needed for initial state setup if needed
          when(
            mockWorkoutRepo.allWorkoutsForUser(mockUser.uid),
          ).thenAnswer((_) => Stream.value(mockWorkouts));
        },
        build: () => homeBloc,
        // Act
        act: (bloc) async {
          // Optional: Load initial state
          // bloc.add(LoadWorkouts());
          // await pumpEventQueue();
          bloc.add(UpdateWorkout(workout: workoutToUpdate));
        },
        // Assert
        expect:
            () => [
              // Optional states if LoadWorkouts was called first
              // HomeLoading(),
              // HomeLoaded(workouts: mockWorkouts),
              HomeError(message: 'Failed to update workout: $testException'),
            ],
        verify: (_) {
          verify(mockWorkoutRepo.updateWorkout(workoutToUpdate)).called(1);
        },
      );
    });
  });
}
