import 'dart:io';

import 'package:dio/dio.dart';
import 'package:money_app_flutter/data/utils/dio_constants.dart';
import 'package:money_app_flutter/domain/models/common/category.dart';
import 'package:money_app_flutter/domain/repositories/categories_repository.dart';
import 'package:money_app_flutter/presentation/di/app_module.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  @override
  Future<List<Category>> getAll() async {
    final token = AppModule.getTokenHolder().apiToken;
    final dio = Dio(
      BaseOptions(
        headers: {
          "Authorization": "Bearer $token",
        },
        validateStatus: (status) => true,
      ),
    );
    final response = await dio.get("${DioConstants.baseUrl}/categories");
    if (response.statusCode != HttpStatus.ok) {
      return [];
    }

    final jsonList = response.data as List<dynamic>;
    return jsonList.map((e) => Category.fromJson(e)).toList();
  }
}
