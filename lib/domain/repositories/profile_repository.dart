import 'package:money_app_flutter/data/utils/api_response.dart';
import 'package:money_app_flutter/domain/models/common/user.dart';

abstract class ProfileRepository {
  Future<ApiResponse<User>> getProfile();
}
