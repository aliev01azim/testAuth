import 'package:dfunc/dfunc.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../dio/dio.dart';
import '../../../../helpers/helpers.dart';
import '../auth_repository.dart';

abstract class RegisterApiClient {
  AsyncResult<UserModel> register(Map<String, dynamic> map);
}

abstract class LoginApiClient {
  AsyncResult<UserModel> login(String email, String password);
}

class RegisterApiClientImpl implements RegisterApiClient {
  @override
  AsyncResult<UserModel> register(Map<String, dynamic> map) async {
    final dio = await getApiClient();
    try {
      final response = await dio.post(
        '/auth/registration/customer/new',
        data: map,
      );
      if (response.statusCode == 200) {
        final bodyJson = response.data as Map<String, dynamic>;
        print(bodyJson);
        print(bodyJson);
        print(bodyJson);
        await Hive.box('tokens').put('data', bodyJson['tokens']);
        return Result.right(UserModel.fromJson(bodyJson['user']));
      }
    } on DioException catch (e) {
      final bodyJson = e.response?.data as Map<String, dynamic>?;
      print(bodyJson);
      if (bodyJson != null) {
        return Result.left(RegisterRequestFailure(text: getError(bodyJson)));
      }
    } on Object catch (_) {
      print('object :$_');
      rethrow;
    }
    return const Result.left(RegisterRequestFailure());
  }
}

class LoginApiClientImpl implements LoginApiClient {
  @override
  AsyncResult<UserModel> login(String password, String email) async {
    final dio = await getApiClient();
    final data = {
      "password": password,
      "email": email,
    };
    try {
      final response = await dio.post(
        '/auth/login',
        data: data,
      );

      if (response.statusCode == 200) {
        final bodyJson = response.data as Map<String, dynamic>;
        await Hive.box('tokens').put('data', bodyJson['tokens']);
        return Result.right(UserModel.fromJson(bodyJson['user']));
      }
    } on DioException catch (e) {
      final bodyJson = e.response?.data as Map<String, dynamic>?;
      if (bodyJson != null) {
        return Result.left(LoginRequestFailure(text: getError(bodyJson)));
      }
    } catch (_) {
      print('object :$_');
      rethrow;
    }
    return const Result.left(LoginRequestFailure());
  }
}

String getError(Map<String, dynamic> errorResponse) {
  // if (errorResponse['error'] is Map<String, dynamic>) {
  //   return (errorResponse['error'] as Map<String, dynamic>).values.join('. \n');
  // }
  return errorResponse['message'];
}
