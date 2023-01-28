import 'package:money_app_flutter/domain/models/common/category.dart';

abstract class CategoriesRepository {
  Future<List<Category>> getAll();
}
