import 'package:dfunc/dfunc.dart';

import 'api_client.dart';
import 'models/user_model.dart';

abstract class RegisterRepository {
  AsyncResult<UserModel> register(Map<String, dynamic> map);
}

class RegisterRepositoryImpl implements RegisterRepository {
  RegisterRepositoryImpl({RegisterApiClientImpl? registerApiClient})
      : _registerApiClient = registerApiClient ?? RegisterApiClientImpl();
  final RegisterApiClientImpl _registerApiClient;
  @override
  AsyncResult<UserModel> register(Map<String, dynamic> map) async =>
      await _registerApiClient.register(map);
}

abstract class LoginRepository {
  AsyncResult<UserModel> login(String password, String email);
}

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({LoginApiClientImpl? loginApiClient})
      : _loginApiClient = loginApiClient ?? LoginApiClientImpl();
  final LoginApiClientImpl _loginApiClient;

  @override
  AsyncResult<UserModel> login(String password, String email) async =>
      await _loginApiClient.login(password, email);
}
