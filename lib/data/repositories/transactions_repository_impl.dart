import 'dart:io';

import 'package:dio/dio.dart';
import 'package:money_app_flutter/data/utils/dio_constants.dart';
import 'package:money_app_flutter/domain/models/common/transaction.dart';
import 'package:money_app_flutter/domain/repositories/transactions_repository.dart';
import 'package:money_app_flutter/presentation/di/app_module.dart';

class TransactionsRepositoryImpl implements TransactionsRepository {
  @override
  Future<List<Transaction>> getAll() async {
    final token = AppModule.getTokenHolder().apiToken;
    final dio = Dio(
      BaseOptions(
        headers: {
          "Authorization": "Bearer $token",
        },
        validateStatus: (status) => true,
      ),
    );
    final response = await dio.get("${DioConstants.baseUrl}/transactions");
    if (response.statusCode != HttpStatus.ok) {
      return [];
    }

    final jsonList = response.data as List<dynamic>;
    return jsonList.map((e) => Transaction.fromJson(e)).toList();
  }
}
