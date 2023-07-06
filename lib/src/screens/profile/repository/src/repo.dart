import 'package:dfunc/dfunc.dart';

import '../../../auth/repository/src/models/user_model.dart';
import 'api_client.dart';

abstract class ProfileRepository {
  AsyncResult<UserModel> getProfile();
}

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({ProfileApiClientImpl? profileApiClient})
      : _profileApiClient = profileApiClient ?? ProfileApiClientImpl();
  final ProfileApiClientImpl _profileApiClient;
  @override
  AsyncResult<UserModel> getProfile() async =>
      await _profileApiClient.getProfile();
}