part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthRegisterEvent extends AuthEvent {
  final String username;
  final String password;
  final String email;
  final String phone;

  AuthRegisterEvent({
    required this.username,
    required this.password,
    required this.email,
    required this.phone,
  });
  @override
  List<Object?> get props => [
        username,
        password,
        email,
        phone,
      ];
}

class AuthLoginEvent extends AuthEvent {
  final String password;
  final String email;

  AuthLoginEvent({
    required this.password,
    required this.email,
  });
  @override
  List<Object> get props => [
        password,
        email,
      ];
}

class AuthLogoutEvent extends AuthEvent {}
