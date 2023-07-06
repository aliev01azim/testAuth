import 'package:auth/src/helpers/helpers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/repository/src/models/user_model.dart';
import '../repository/src/repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required ProfileRepositoryImpl profileRepository,
  })  : _profileRepository = profileRepository,
        super(ProfileInitial()) {
    UserModel? user;
    on<ProfileGetEvent>(
      (event, emit) async {
        if (event.user != null) {
          user = event.user;
          emit(ProfileLoaded(event.user!));
        } else if (user != null) {
          emit(ProfileLoaded(user!));
        } else {
          emit(ProfileLoading());
          final loginResponse = await _profileRepository.getProfile();
          loginResponse.fold(
            (exc) {
              if (exc is ProfileRequestFailure) {
                emit(ProfileError(exc.text));
              }
            },
            (user) => emit(ProfileLoaded(user)),
          );
        }
      },
    );
    on<ProfileReset>((event, emit) async {
      user = null;
      emit(ProfileInitial());
    });
  }

  final ProfileRepositoryImpl _profileRepository;
}
