import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_app_flutter/domain/models/common/asset.dart';
import 'package:money_app_flutter/domain/models/common/category.dart';

part 'transaction.freezed.dart';

part 'transaction.g.dart';

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required int id,
    required String title,
    required double amount,
    required Category category,
    required Asset asset,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
