import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

class AccountCheckStatus extends AccountEvent {}

class AccountToggleMode extends AccountEvent {}

class AccountLoginRequested extends AccountEvent {
  final String email;
  final String password;

  const AccountLoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AccountSignUpRequested extends AccountEvent {
  final String email;
  final String password;

  const AccountSignUpRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AccountLogOutRequested extends AccountEvent {}

class AccountDeleteAccountRequested extends AccountEvent {
  final String password;

  const AccountDeleteAccountRequested({required this.password});
}
