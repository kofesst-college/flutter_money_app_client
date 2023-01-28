import 'package:money_app_flutter/domain/models/common/asset.dart';

abstract class AssetsRepository {
  Future<List<Asset>> getAll();
}