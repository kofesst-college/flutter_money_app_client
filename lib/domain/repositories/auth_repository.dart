import 'package:money_app_flutter/data/utils/api_response.dart';

abstract class AuthRepository {
  Future<ApiResponse<String>> refreshToken(
    String currentToken,
  );

  Future<ApiResponse<String>> signIn(
    String username,
    String password,
  );

  Future<ApiResponse<String>> signUp(
    String email,
    String username,
    String password,
  );
}
