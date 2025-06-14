// Mocks generated by Mockito 5.4.5 from annotations
// in fit_tick_mobile/test/features/workout/workout_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:fit_tick_mobile/data/exercise/exercise.dart' as _i3;
import 'package:fit_tick_mobile/data/exercise/exercise_repo.dart' as _i6;
import 'package:fit_tick_mobile/data/workout/workout.dart' as _i2;
import 'package:fit_tick_mobile/data/workout/workout_repo.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeWorkout_0 extends _i1.SmartFake implements _i2.Workout {
  _FakeWorkout_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeExercise_1 extends _i1.SmartFake implements _i3.Exercise {
  _FakeExercise_1(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [WorkoutRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockWorkoutRepo extends _i1.Mock implements _i4.WorkoutRepo {
  MockWorkoutRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<void> createWorkout(_i2.Workout? workout) =>
      (super.noSuchMethod(
            Invocation.method(#createWorkout, [workout]),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);

  @override
  _i5.Future<_i2.Workout> readWorkout(String? workoutId) =>
      (super.noSuchMethod(
            Invocation.method(#readWorkout, [workoutId]),
            returnValue: _i5.Future<_i2.Workout>.value(
              _FakeWorkout_0(
                this,
                Invocation.method(#readWorkout, [workoutId]),
              ),
            ),
          )
          as _i5.Future<_i2.Workout>);

  @override
  _i5.Stream<List<_i2.Workout>> allWorkoutsForUser(String? userIdForQuery) =>
      (super.noSuchMethod(
            Invocation.method(#allWorkoutsForUser, [userIdForQuery]),
            returnValue: _i5.Stream<List<_i2.Workout>>.empty(),
          )
          as _i5.Stream<List<_i2.Workout>>);

  @override
  _i5.Future<List<_i2.Workout>> allWorkoutsForUserAsList(
    String? userIdForQuery,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#allWorkoutsForUserAsList, [userIdForQuery]),
            returnValue: _i5.Future<List<_i2.Workout>>.value(<_i2.Workout>[]),
          )
          as _i5.Future<List<_i2.Workout>>);

  @override
  _i5.Future<void> updateWorkout(_i2.Workout? workout) =>
      (super.noSuchMethod(
            Invocation.method(#updateWorkout, [workout]),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);

  @override
  _i5.Future<void> deleteWorkout(String? workoutId) =>
      (super.noSuchMethod(
            Invocation.method(#deleteWorkout, [workoutId]),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);

  @override
  _i5.Future<void> deleteAllWorkoutsForUser(String? userId) =>
      (super.noSuchMethod(
            Invocation.method(#deleteAllWorkoutsForUser, [userId]),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);
}

/// A class which mocks [ExerciseRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockExerciseRepo extends _i1.Mock implements _i6.ExerciseRepo {
  MockExerciseRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<void> createExercise(String? workoutId, _i3.Exercise? exercise) =>
      (super.noSuchMethod(
            Invocation.method(#createExercise, [workoutId, exercise]),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);

  @override
  _i5.Future<_i3.Exercise> readExercise(
    String? workoutId,
    String? exerciseId,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#readExercise, [workoutId, exerciseId]),
            returnValue: _i5.Future<_i3.Exercise>.value(
              _FakeExercise_1(
                this,
                Invocation.method(#readExercise, [workoutId, exerciseId]),
              ),
            ),
          )
          as _i5.Future<_i3.Exercise>);

  @override
  _i5.Future<List<_i3.Exercise>> allExercisesForWorkout(String? workoutId) =>
      (super.noSuchMethod(
            Invocation.method(#allExercisesForWorkout, [workoutId]),
            returnValue: _i5.Future<List<_i3.Exercise>>.value(<_i3.Exercise>[]),
          )
          as _i5.Future<List<_i3.Exercise>>);

  @override
  _i5.Future<void> updateExercise(String? workoutId, _i3.Exercise? exercise) =>
      (super.noSuchMethod(
            Invocation.method(#updateExercise, [workoutId, exercise]),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);

  @override
  _i5.Future<void> deleteExercise(String? workoutId, String? exerciseId) =>
      (super.noSuchMethod(
            Invocation.method(#deleteExercise, [workoutId, exerciseId]),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);
}
