import 'package:auth/src/helpers/helpers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required RegisterRepositoryImpl registerRepository,
    required LoginRepositoryImpl loginRepository,
  })  : _registerRepository = registerRepository,
        _loginRepository = loginRepository,
        super(AuthInitial()) {
    on<AuthRegisterEvent>((event, emit) async {
      emit(AuthRegistering());
      final data = {
        "nickname": event.username,
        "password": event.password,
        "email": event.email,
        "phone": event.phone,
      };
      final regResponse = await _registerRepository.register(data);
      regResponse.fold(
        (exc) {
          if (exc is RegisterRequestFailure) {
            emit(AuthError(exc.text));
          }
        },
        (user) => emit(AuthLoaded(user)),
      );
    });
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLogining());
      final loginResponse =
          await _loginRepository.login(event.password, event.email);
      loginResponse.fold(
        (exc) {
          if (exc is LoginRequestFailure) {
            emit(AuthError(exc.text));
          }
        },
        (user) => emit(AuthLoaded(user)),
      );
    });
    on<AuthLogoutEvent>((event, emit) async {
      await Hive.box('tokens').delete('data');
      emit(AuthInitial());
    });
  }
  final RegisterRepositoryImpl _registerRepository;
  final LoginRepositoryImpl _loginRepository;
}
