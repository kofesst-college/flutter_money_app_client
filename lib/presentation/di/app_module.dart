import 'package:get_it/get_it.dart';
import 'package:money_app_flutter/data/repositories/assets_repository_impl.dart';
import 'package:money_app_flutter/data/repositories/auth_repository_impl.dart';
import 'package:money_app_flutter/data/repositories/categories_repository_impl.dart';
import 'package:money_app_flutter/data/repositories/preferences_repository_impl.dart';
import 'package:money_app_flutter/data/repositories/profile_repository_impl.dart';
import 'package:money_app_flutter/data/repositories/transactions_repository_impl.dart';
import 'package:money_app_flutter/domain/repositories/assets_repository.dart';
import 'package:money_app_flutter/domain/repositories/auth_repository.dart';
import 'package:money_app_flutter/domain/repositories/categories_repository.dart';
import 'package:money_app_flutter/domain/repositories/preferences_repository.dart';
import 'package:money_app_flutter/domain/repositories/profile_repository.dart';
import 'package:money_app_flutter/domain/repositories/transactions_repository.dart';
import 'package:money_app_flutter/presentation/di/token_holder.dart';

class AppModule {
  static bool _provided = false;

  void provideDependencies() {
    if (_provided) return;

    _provideTokenHolder();
    _provideAuthRepository();
    _provideProfileRepository();
    _provideAssetsRepository();
    _provideCategoriesRepository();
    _provideTransactionsRepository();
    _providePreferencesRepository();

    _provided = true;
  }

  void _provideTokenHolder() {
    GetIt.instance.registerSingleton(TokenHolder());
  }

  static TokenHolder getTokenHolder() {
    return GetIt.instance.get<TokenHolder>();
  }

  void _provideAuthRepository() {
    GetIt.instance.registerSingleton(AuthRepositoryImpl());
  }

  static AuthRepository getAuthRepository() {
    return GetIt.instance.get<AuthRepositoryImpl>();
  }

  void _provideProfileRepository() {
    GetIt.instance.registerSingleton(ProfileRepositoryImpl());
  }

  static ProfileRepository getProfileRepository() {
    return GetIt.instance.get<ProfileRepositoryImpl>();
  }

  void _provideAssetsRepository() {
    GetIt.instance.registerSingleton(AssetsRepositoryImpl());
  }

  static AssetsRepository getAssetsRepository() {
    return GetIt.instance.get<AssetsRepositoryImpl>();
  }

  void _provideCategoriesRepository() {
    GetIt.instance.registerSingleton(CategoriesRepositoryImpl());
  }

  static CategoriesRepository getCategoriesRepository() {
    return GetIt.instance.get<CategoriesRepositoryImpl>();
  }

  void _provideTransactionsRepository() {
    GetIt.instance.registerSingleton(TransactionsRepositoryImpl());
  }

  static TransactionsRepository getTransactionsRepository() {
    return GetIt.instance.get<TransactionsRepositoryImpl>();
  }

  void _providePreferencesRepository() {
    final authRepository = getAuthRepository();
    GetIt.instance.registerSingleton(
      PreferencesRepositoryImpl(
        authRepository: authRepository,
      ),
    );
  }

  static PreferencesRepository getPreferencesRepository() {
    if (!_provided) throw Exception("Value not provided");
    return GetIt.instance.get<PreferencesRepositoryImpl>();
  }
}
