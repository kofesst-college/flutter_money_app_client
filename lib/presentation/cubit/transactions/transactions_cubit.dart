import 'package:bloc/bloc.dart';
import 'package:money_app_flutter/domain/models/common/transaction.dart';
import 'package:money_app_flutter/presentation/di/app_module.dart';
import 'package:money_app_flutter/presentation/utils/loading_status.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit() : super(TransactionsState(status: IdleStatus()));

  Future<void> load() async {
    final repository = AppModule.getTransactionsRepository();
    emit(TransactionsState(status: LoadingStatus()));
    try {
      final transactions = await repository.getAll();
      emit(TransactionsState(status: LoadedStatus(transactions)));
    } catch (exception) {
      emit(TransactionsState(status: FailedStatus(exception.toString())));
    }
  }
}
