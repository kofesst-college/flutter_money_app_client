import 'package:bloc/bloc.dart';
import 'package:money_app_flutter/domain/models/common/asset.dart';
import 'package:money_app_flutter/presentation/di/app_module.dart';
import 'package:money_app_flutter/presentation/utils/loading_status.dart';

part 'assets_state.dart';

class AssetsCubit extends Cubit<AssetsState> {
  AssetsCubit() : super(AssetsState(status: IdleStatus()));

  Future<void> load() async {
    final repository = AppModule.getAssetsRepository();
    emit(AssetsState(status: LoadingStatus()));
    try {
      final assets = await repository.getAll();
      emit(AssetsState(status: LoadedStatus(assets)));
    } catch (exception) {
      emit(AssetsState(status: FailedStatus(exception.toString())));
    }
  }
}
