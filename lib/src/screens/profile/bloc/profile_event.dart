part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileGetEvent extends ProfileEvent {
  final UserModel? user;
  ProfileGetEvent(this.user);
  @override
  List<Object?> get props => [user];
}

class ProfileReset extends ProfileEvent {
  ProfileReset();
  @override
  List<Object?> get props => [];
}
