part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoaded extends ProfileState {
  final UserModel user;

  ProfileLoaded(this.user);
  @override
  List<Object> get props => [user];
}

class ProfileLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileError extends ProfileState {
  final String error;
  ProfileError(this.error);
  @override
  List<Object> get props => [error];
}
