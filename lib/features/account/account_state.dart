import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object?> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLogin extends AccountState {
  final String? message;
  const AccountLogin({this.message});

  @override
  List<Object?> get props => [message];
}

class AccountSignUp extends AccountState {
  final String? error;
  const AccountSignUp({this.error});

  @override
  List<Object?> get props => [error];
}

class AccountLoggedIn extends AccountState {
  final User user;
  const AccountLoggedIn({required this.user});

  @override
  List<Object?> get props => [user];
}

class AccountError extends AccountState {
  final String message;
  const AccountError({required this.message});

  @override
  List<Object?> get props => [message];
}
