import 'package:bloc/bloc.dart';
import 'package:money_app_flutter/domain/models/common/category.dart';
import 'package:money_app_flutter/presentation/di/app_module.dart';
import 'package:money_app_flutter/presentation/utils/loading_status.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesState(status: IdleStatus()));

  Future<void> load() async {
    final repository = AppModule.getCategoriesRepository();
    emit(CategoriesState(status: LoadingStatus()));
    try {
      final categories = await repository.getAll();
      emit(CategoriesState(status: LoadedStatus(categories)));
    } catch (exception) {
      emit(CategoriesState(status: FailedStatus(exception.toString())));
    }
  }
}
