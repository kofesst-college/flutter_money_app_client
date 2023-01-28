import 'package:money_app_flutter/domain/models/common/transaction.dart';

abstract class TransactionsRepository {
  Future<List<Transaction>> getAll();
}
