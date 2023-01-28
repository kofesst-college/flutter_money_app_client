import 'dart:io';

import 'package:dio/dio.dart';
import 'package:money_app_flutter/data/utils/api_response.dart';
import 'package:money_app_flutter/data/utils/dio_constants.dart';
import 'package:money_app_flutter/domain/models/common/user.dart';
import 'package:money_app_flutter/domain/repositories/profile_repository.dart';
import 'package:money_app_flutter/presentation/di/app_module.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<ApiResponse<User>> getProfile() async {
    final token = AppModule.getTokenHolder().apiToken;
    final dio = Dio(
      BaseOptions(
        headers: {
          "Authorization": "Bearer $token",
        },
        validateStatus: (status) => true,
      ),
    );
    final response = await dio.get("${DioConstants.baseUrl}/user");
    if (response.statusCode != HttpStatus.ok) {
      final message = response.data["message"];
      return ApiResponse(
        hasError: true,
        data: null,
        message: message,
      );
    }

    final user = User.fromJson(response.data["data"]);
    return ApiResponse(
      hasError: false,
      data: user,
      message: null,
    );
  }
}
