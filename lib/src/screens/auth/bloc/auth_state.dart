part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoaded extends AuthState {
  final UserModel user;

  AuthLoaded(this.user);
  @override
  List<Object> get props => [user];
}

class AuthRegistering extends AuthState {
  @override
  List<Object> get props => [];
}
class AuthLogining extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthError extends AuthState {
  final String error;
  AuthError(this.error);
  @override
  List<Object> get props => [error];
}
