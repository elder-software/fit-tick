import 'package:fit_tick_mobile/data/auth/auth_service.dart';
import 'package:fit_tick_mobile/data/workout/workout_repo.dart';
import 'package:fit_tick_mobile/features/account/account_event.dart';
import 'package:fit_tick_mobile/features/account/account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AuthService _authService;
  final WorkoutRepo _workoutRepo;

  AccountBloc({
    required AuthService authService,
    required WorkoutRepo workoutRepo,
  }) : _authService = authService,
       _workoutRepo = workoutRepo,
       super(AccountInitial()) {
    on<AccountCheckStatus>(_onCheckStatus);
    on<AccountToggleMode>(_onToggleMode);
    on<AccountLoginRequested>(_onLoginRequested);
    on<AccountSignUpRequested>(_onSignUpRequested);
    on<AccountLogOutRequested>(_onLogOutRequested);
    on<AccountDeleteAccountRequested>(_onDeleteAccountRequested);

    _authService.authStateChanges.listen((user) {
      add(AccountCheckStatus());
    });
  }

  void _onCheckStatus(AccountCheckStatus event, Emitter<AccountState> emit) {
    final user = _authService.currentUser;
    if (user != null && !user.isAnonymous) {
      emit(AccountLoggedIn(user: user));
    } else {
      emit(const AccountLogin());
    }
  }

  void _onToggleMode(AccountToggleMode event, Emitter<AccountState> emit) {
    if (state is AccountLogin) {
      emit(const AccountSignUp());
    } else if (state is AccountSignUp) {
      emit(const AccountLogin());
    } else if (state is AccountError) {
      emit(const AccountLogin());
    }
  }

  Future<void> _onLoginRequested(
    AccountLoginRequested event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    try {
      final userCredential = await _authService.logInWithEmailAndPassword(
        event.email,
        event.password,
      );
      if (userCredential?.user != null) {
        emit(AccountLoggedIn(user: userCredential!.user!));
      } else {
        emit(
          const AccountLogin(
            message: 'Login failed. Please check your credentials.',
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      emit(AccountLogin(message: e.message ?? 'An unknown error occurred.'));
    } catch (e) {
      emit(AccountLogin(message: e.toString()));
    }
  }

  Future<void> _onSignUpRequested(
    AccountSignUpRequested event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    try {
      final userCredential = await _authService.linkAnonymousAccountWithEmail(
        event.email,
        event.password,
      );

      if (userCredential?.user != null) {
        if (!userCredential!.user!.isAnonymous) {
          emit(AccountLoggedIn(user: userCredential.user!));
        } else {
          print("Warning: User is still anonymous after linking attempt.");
          emit(const AccountSignUp(error: 'Linking failed. Please try again.'));
        }
      } else {
        emit(const AccountSignUp(error: 'Sign up failed. Please try again.'));
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = e.message ?? 'An unknown error occurred.';
      if (e.code == 'email-already-in-use') {
        errorMessage = 'This email is already registered. Try logging in.';
      } else if (e.code == 'credential-already-in-use') {
        errorMessage = 'This account is already linked to another user.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'not-anonymous') {
        errorMessage = 'Internal error: Linking requires an anonymous session.';
      }
      emit(AccountSignUp(error: errorMessage));
    } catch (e) {
      emit(
        AccountSignUp(error: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  Future<void> _onLogOutRequested(
    AccountLogOutRequested event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    try {
      await _authService.logOut();
      emit(const AccountLogin());
    } catch (e) {
      emit(AccountError(message: 'Failed to log out: ${e.toString()}'));
      final user = _authService.currentUser;
      if (user != null) {
        emit(AccountLoggedIn(user: user));
      }
    }
  }

  Future<void> _onDeleteAccountRequested(
    AccountDeleteAccountRequested event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    final user = _authService.currentUser;
    if (user == null) {
      emit(AccountError(message: 'No user found to delete account.'));
      return;
    }
    try {
      await _workoutRepo.deleteAllWorkoutsForUser(user.uid);
      await _authService.deleteAccount(event.password);
      emit(const AccountLogin(message: 'Account deleted successfully.'));
    } catch (e) {
      emit(AccountError(message: 'Failed to delete account.'));
    }
  }
}
