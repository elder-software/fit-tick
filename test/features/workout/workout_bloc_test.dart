import 'package:bloc_test/bloc_test.dart';
import 'package:fit_tick_mobile/data/exercise/exercise.dart';
import 'package:fit_tick_mobile/data/exercise/exercise_repo.dart';
import 'package:fit_tick_mobile/data/workout/workout.dart';
import 'package:fit_tick_mobile/data/workout/workout_repo.dart';
import 'package:fit_tick_mobile/features/workout/workout_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'workout_bloc_test.mocks.dart';

@GenerateMocks([WorkoutRepo, ExerciseRepo])
void main() {
  late MockWorkoutRepo mockWorkoutRepo;
  late MockExerciseRepo mockExerciseRepo;
  late WorkoutBloc workoutBloc;

  final testWorkout = Workout(id: 'w1', userId: 'user1', name: 'Test Workout');
  final testUpdatedWorkout = Workout(
    id: 'w1',
    userId: 'user1',
    name: 'Updated Name',
  );
  final testExercises = [
    Exercise(
      id: 'e1',
      name: 'Push Ups',
      index: "00001",
      exerciseTime: 45,
      restTime: 15,
      description: 'Standard push-ups',
    ),
    Exercise(
      id: 'e2',
      name: 'Squats',
      index: "00002",
      exerciseTime: 60,
      restTime: 15,
      description: 'Bodyweight squats',
    ),
  ];

  setUp(() {
    mockWorkoutRepo = MockWorkoutRepo();
    mockExerciseRepo = MockExerciseRepo();
    workoutBloc = WorkoutBloc(
      workoutRepo: mockWorkoutRepo,
      exerciseRepo: mockExerciseRepo,
    );
  });

  tearDown(() {
    workoutBloc.close();
  });

  group('WorkoutBloc', () {
    test('initial state is Initial', () {
      expect(workoutBloc.state, Initial());
    });

    blocTest<WorkoutBloc, WorkoutState>(
      'emits [WorkoutLoaded] when LoadScreen is added and fetching succeeds',
      build: () {
        when(
          mockWorkoutRepo.readWorkout(any),
        ).thenAnswer((_) async => testWorkout);
        when(
          mockExerciseRepo.allExercisesForWorkout(any),
        ).thenAnswer((_) async => testExercises);
        return workoutBloc;
      },
      act: (bloc) => bloc.add(const LoadScreen(workoutId: 'w1')),
      expect:
          () => [
            WorkoutLoaded(
              workout: testWorkout,
              exercises: testExercises,
              exercisesLoading: false,
              transientErrorMessage: null,
            ),
          ],
      verify: (_) {
        verify(mockWorkoutRepo.readWorkout('w1')).called(1);
        verify(mockExerciseRepo.allExercisesForWorkout('w1')).called(1);
      },
    );

    blocTest<WorkoutBloc, WorkoutState>(
      'emits [ErrorScreen] when LoadScreen is added and fetching workout fails',
      build: () {
        when(
          mockWorkoutRepo.readWorkout(any),
        ).thenThrow(Exception('Failed to load workout'));
        return workoutBloc;
      },
      act: (bloc) => bloc.add(const LoadScreen(workoutId: 'w1')),
      expect: () => [const ErrorScreen(message: 'Error loading workout.')],
      verify: (_) {
        verify(mockWorkoutRepo.readWorkout('w1')).called(1);
        verifyNever(mockExerciseRepo.allExercisesForWorkout(any));
      },
    );

    blocTest<WorkoutBloc, WorkoutState>(
      'emits [ErrorScreen] when LoadScreen is added and fetching exercises fails',
      build: () {
        when(
          mockWorkoutRepo.readWorkout(any),
        ).thenAnswer((_) async => testWorkout);
        when(
          mockExerciseRepo.allExercisesForWorkout(any),
        ).thenThrow(Exception('Failed to load exercises'));
        return workoutBloc;
      },
      act: (bloc) => bloc.add(const LoadScreen(workoutId: 'w1')),
      expect: () => [const ErrorScreen(message: 'Error loading workout.')],
      verify: (_) {
        verify(mockWorkoutRepo.readWorkout('w1')).called(1);
        verify(mockExerciseRepo.allExercisesForWorkout('w1')).called(1);
      },
    );

    blocTest<WorkoutBloc, WorkoutState>(
      'emits [Initial] when InitialEvent is added',
      build: () => workoutBloc,
      act: (bloc) => bloc.add(InitialEvent()),
      expect: () => [Initial()],
    );

    blocTest<WorkoutBloc, WorkoutState>(
      'emits [WorkoutLoaded] with updated workout when UpdateWorkout is added',
      seed:
          () => WorkoutLoaded(
            workout: testWorkout,
            exercises: testExercises,
            exercisesLoading: false,
          ),
      build: () {
        when(mockWorkoutRepo.updateWorkout(any)).thenAnswer((_) async {});
        return workoutBloc;
      },
      act: (bloc) => bloc.add(UpdateWorkout(workout: testUpdatedWorkout)),
      expect:
          () => [
            WorkoutLoaded(
              workout: testUpdatedWorkout,
              exercises: testExercises,
              exercisesLoading: false,
              transientErrorMessage: null,
            ),
          ],
      verify: (_) {
        verify(mockWorkoutRepo.updateWorkout(testUpdatedWorkout)).called(1);
      },
    );

    blocTest<WorkoutBloc, WorkoutState>(
      'emits [ErrorScreen] when UpdateWorkout fails',
      seed:
          () => WorkoutLoaded(
            workout: testWorkout,
            exercises: testExercises,
            exercisesLoading: false,
          ),
      build: () {
        when(
          mockWorkoutRepo.updateWorkout(any),
        ).thenThrow(Exception('Update failed'));
        return workoutBloc;
      },
      act:
          (bloc) => bloc.add(
            UpdateWorkout(workout: testWorkout.copyWith(name: 'Updated Name')),
          ),
      expect: () => [const ErrorScreen(message: 'Error updating workout.')],
      verify: (_) {
        verify(
          mockWorkoutRepo.updateWorkout(
            argThat(
              isA<Workout>().having((w) => w.name, 'name', 'Updated Name'),
            ),
          ),
        ).called(1);
      },
    );

    blocTest<WorkoutBloc, WorkoutState>(
      'emits [Initial] when DeleteWorkout is added and succeeds',
      seed:
          () => WorkoutLoaded(
            workout: testWorkout,
            exercises: testExercises,
            exercisesLoading: false,
          ),
      build: () {
        when(mockWorkoutRepo.deleteWorkout(any)).thenAnswer((_) async {});
        return workoutBloc;
      },
      act: (bloc) => bloc.add(const DeleteWorkout(workoutId: 'w1')),
      expect: () => [Initial()],
      verify: (_) {
        verify(mockWorkoutRepo.deleteWorkout('w1')).called(1);
      },
    );

    blocTest<WorkoutBloc, WorkoutState>(
      'emits [ErrorScreen] when DeleteWorkout fails',
      seed:
          () => WorkoutLoaded(
            workout: testWorkout,
            exercises: testExercises,
            exercisesLoading: false,
          ),
      build: () {
        when(
          mockWorkoutRepo.deleteWorkout(any),
        ).thenThrow(Exception('Delete failed'));
        return workoutBloc;
      },
      act: (bloc) => bloc.add(const DeleteWorkout(workoutId: 'w1')),
      expect: () => [const ErrorScreen(message: 'Error deleting workout.')],
      verify: (_) {
        verify(mockWorkoutRepo.deleteWorkout('w1')).called(1);
      },
    );

    blocTest<WorkoutBloc, WorkoutState>(
      'emits [WorkoutLoaded(loading=true), WorkoutLoaded(loading=false)] when DeleteExercise is added and succeeds',
      seed:
          () => WorkoutLoaded(
            workout: testWorkout,
            exercises: testExercises,
            exercisesLoading: false,
          ),
      build: () {
        when(
          mockExerciseRepo.deleteExercise(any, any),
        ).thenAnswer((_) async {});
        // Mock the reload triggered by LoadScreen after delete
        when(
          mockWorkoutRepo.readWorkout(any),
        ).thenAnswer((_) async => testWorkout);
        when(mockExerciseRepo.allExercisesForWorkout(any)).thenAnswer(
          (_) async => testExercises.where((ex) => ex.id != 'e1').toList(),
        );
        return workoutBloc;
      },
      act:
          (bloc) =>
              bloc.add(const DeleteExercise(workoutId: 'w1', exerciseId: 'e1')),
      expect:
          () => [
            // State when starting delete
            WorkoutLoaded(
              workout: testWorkout,
              exercises: testExercises,
              exercisesLoading: true,
              transientErrorMessage: null,
            ),
            // State after reload (LoadScreen)
            WorkoutLoaded(
              workout: testWorkout,
              exercises: testExercises.where((ex) => ex.id != 'e1').toList(),
              exercisesLoading: false,
              transientErrorMessage: null,
            ),
          ],
      verify: (_) {
        verify(mockExerciseRepo.deleteExercise('w1', 'e1')).called(1);
        verify(
          mockWorkoutRepo.readWorkout('w1'),
        ).called(1); // Called by LoadScreen
        verify(
          mockExerciseRepo.allExercisesForWorkout('w1'),
        ).called(1); // Called by LoadScreen
      },
    );

    blocTest<WorkoutBloc, WorkoutState>(
      'emits [ErrorScreen] when DeleteExercise fails',
      seed:
          () => WorkoutLoaded(
            workout: testWorkout,
            exercises: testExercises,
            exercisesLoading: false,
          ),
      build: () {
        when(
          mockExerciseRepo.deleteExercise(any, any),
        ).thenThrow(Exception('Delete exercise failed'));
        return workoutBloc;
      },
      act:
          (bloc) =>
              bloc.add(const DeleteExercise(workoutId: 'w1', exerciseId: 'e1')),
      expect:
          () => [
            // State when starting delete
            WorkoutLoaded(
              workout: testWorkout,
              exercises: testExercises,
              exercisesLoading: true,
              transientErrorMessage: null,
            ),
            const ErrorScreen(message: 'Error deleting exercise.'),
          ],
      verify: (_) {
        verify(mockExerciseRepo.deleteExercise('w1', 'e1')).called(1);
      },
    );

    blocTest<WorkoutBloc, WorkoutState>(
      'emits [WorkoutLoaded(loading=true), WorkoutLoaded(loading=false)] when LoadExercises is added',
      seed:
          () => WorkoutLoaded(
            workout: testWorkout,
            exercises: [], // Start with empty exercises
            exercisesLoading: false,
          ),
      build: () {
        when(
          mockExerciseRepo.allExercisesForWorkout(any),
        ).thenAnswer((_) async => testExercises);
        return workoutBloc;
      },
      act:
          (bloc) =>
              bloc.add(LoadExercises(workoutId: 'w1', workout: testWorkout)),
      expect:
          () => [
            WorkoutLoaded(
              workout: testWorkout,
              exercises: [],
              exercisesLoading: true,
              transientErrorMessage: null,
            ),
            WorkoutLoaded(
              workout: testWorkout,
              exercises: testExercises,
              exercisesLoading: false,
              transientErrorMessage: null,
            ),
          ],
      verify: (_) {
        verify(mockExerciseRepo.allExercisesForWorkout('w1')).called(1);
      },
    );

    blocTest<WorkoutBloc, WorkoutState>(
      'emits [ErrorScreen] when LoadExercises fails',
      seed:
          () => WorkoutLoaded(
            workout: testWorkout,
            exercises: [],
            exercisesLoading: false,
          ),
      build: () {
        when(
          mockExerciseRepo.allExercisesForWorkout(any),
        ).thenThrow(Exception('Load exercises failed'));
        return workoutBloc;
      },
      act:
          (bloc) =>
              bloc.add(LoadExercises(workoutId: 'w1', workout: testWorkout)),
      expect:
          () => [
            WorkoutLoaded(
              workout: testWorkout,
              exercises: [],
              exercisesLoading: true,
              transientErrorMessage: null,
            ),
            const ErrorScreen(message: 'Error loading exercises.'),
          ],
      verify: (_) {
        verify(mockExerciseRepo.allExercisesForWorkout('w1')).called(1);
      },
    );

    blocTest<WorkoutBloc, WorkoutState>(
      'emits [WorkoutLoaded] with transient error message when ShowTransientError is added',
      seed:
          () => WorkoutLoaded(
            workout: testWorkout,
            exercises: testExercises,
            exercisesLoading: false,
          ),
      build: () => workoutBloc,
      act: (bloc) => bloc.add(const ShowTransientError(message: 'Test Error')),
      expect:
          () => [
            WorkoutLoaded(
              workout: testWorkout,
              exercises: testExercises,
              exercisesLoading: false,
              transientErrorMessage: 'Test Error',
            ),
          ],
    );

    blocTest<WorkoutBloc, WorkoutState>(
      'does not emit new state when ShowTransientError is added if state is not WorkoutLoaded',
      seed: () => Initial(), // Start with a non-WorkoutLoaded state
      build: () => workoutBloc,
      act: (bloc) => bloc.add(const ShowTransientError(message: 'Test Error')),
      expect: () => [], // No state change expected
    );
  });
}
