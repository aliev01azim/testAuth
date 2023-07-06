import 'package:dfunc/dfunc.dart';
import 'package:dio/dio.dart';

import '../../../../dio/dio.dart';
import '../../../../helpers/helpers.dart';
import '../../../auth/repository/src/models/user_model.dart';

abstract class ProfileApiClient {
  AsyncResult<UserModel> getProfile();
}

class ProfileApiClientImpl implements ProfileApiClient {
  @override
  AsyncResult<UserModel> getProfile() async {
    final dio = await getApiClient();
    try {
      final response = await dio.get(
        '/auth/login/profile',
      );
      if (response.statusCode == 200) {
        final bodyJson = response.data as Map<String, dynamic>;
        return Result.right(UserModel.fromJson(bodyJson));
      }
    } on DioException catch (e) {
      final bodyJson = e.response?.data as Map<String, dynamic>?;
      print(bodyJson);
      if (bodyJson != null) {
        return Result.left(ProfileRequestFailure(text: bodyJson['message']));
      }
    } on Object catch (_) {
      print('object :$_');
      rethrow;
    }
    return const Result.left(ProfileRequestFailure());
  }
}
