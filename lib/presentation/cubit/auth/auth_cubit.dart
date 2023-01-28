import 'package:bloc/bloc.dart';
import 'package:money_app_flutter/presentation/di/app_module.dart';
import 'package:money_app_flutter/presentation/utils/loading_status.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState(tokenStatus: IdleStatus()));

  Future<String?> signIn({
    required String username,
    required String password,
  }) async {
    final repository = AppModule.getAuthRepository();
    emit(AuthState(tokenStatus: LoadingStatus()));
    try {
      final token = await repository.signIn(username, password);
      if (token.hasError || token.data == null) {
        throw Exception(
          token.message ?? 'Ошибка на стороне сервера (auth_cubit)',
        );
      }
      AppModule.getTokenHolder().apiToken = token.data!;
      AppModule.getPreferencesRepository().saveApiToken(token.data!);
      emit(AuthState(tokenStatus: LoadedStatus(token.data!)));
      return null;
    } catch (exception) {
      emit(AuthState(tokenStatus: FailedStatus(exception.toString())));
      return exception.toString();
    }
  }

  Future<String?> signUp({
    required String email,
    required String username,
    required String password,
  }) async {
    final repository = AppModule.getAuthRepository();
    emit(AuthState(tokenStatus: LoadingStatus()));
    try {
      final token = await repository.signUp(email, username, password);
      if (token.hasError || token.data == null) {
        throw Exception(
          token.message ?? 'Ошибка на стороне сервера (auth_cubit)',
        );
      }
      AppModule.getTokenHolder().apiToken = token.data!;
      AppModule.getPreferencesRepository().saveApiToken(token.data!);
      emit(AuthState(tokenStatus: LoadedStatus(token.data!)));
      return null;
    } catch (exception) {
      emit(AuthState(tokenStatus: FailedStatus(exception.toString())));
      return exception.toString();
    }
  }
}
