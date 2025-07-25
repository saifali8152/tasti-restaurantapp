import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/parms/parms.dart';
import '/features/admin/transaction_history/domain/entities/transaction_history.dart';
import '/features/admin/transaction_history/domain/usecases/fetch_admin_transaction_history.dart';
import '/core/network/response.dart';
import 'transaction_history_event.dart';
import 'transaction_history_state.dart';

class FetchTransactionHistoryBloc
    extends Bloc<FetchTransactionHistoryEvent, TransactionHistoryState> {
  final FetchAdminTransactionHistory _useCase;

  FetchTransactionHistoryBloc(this._useCase) : super(FetchTransactionHistoryInitial()) {
    on<FetchInitialTransactionHistory>(_onFetchInitialTransactionHistory);
    on<FetchMoreTransactionHistory>(_onFetchMoreTransactionHistory);
  }

  Future<void> _onFetchInitialTransactionHistory(FetchInitialTransactionHistory event,
      Emitter<TransactionHistoryState> emit) async {
    emit(FetchTransactionHistoryLoading());

    try {
      final parms = PaginationParms(
        page: '1',
        search: '',
      );
      final result = await _useCase.call(parms);

      if (result is DataSuccess<TransactionHistoryEntity>) {
        emit(FetchTransactionHistoryLoaded(data: result.data.data, pagination: result.data.pagination));
      } else if (result is DataFailure<TransactionHistoryEntity>) {
        emit(FetchTransactionHistoryError(result.error.toString()));
      }
    } catch (e) {
      emit(FetchTransactionHistoryError(e.toString()));
    }
  }

  Future<void> _onFetchMoreTransactionHistory(FetchMoreTransactionHistory event,
      Emitter<TransactionHistoryState> emit) async {
    final currentState = state;

    if (currentState is FetchTransactionHistoryLoaded &&
        currentState.pagination.hasNext &&
        !currentState.isLoadingMore) {
      emit(currentState.copyWith(isLoadingMore: true));

      try {
        final nextPage = currentState.pagination.currentPage + 1;
        final parms = PaginationParms(
          page: nextPage.toString(),
        );
        final result = await _useCase.call(parms);

        if (result is DataSuccess<TransactionHistoryEntity>) {
          final newData = result.data;

          final updatedList = List<TransactionHistoryItem>.from(currentState.data)
            ..addAll(newData.data);

          emit(FetchTransactionHistoryLoaded(
            data: updatedList,
            pagination: newData.pagination,
            isLoadingMore: false,
          ));
        } else if (result is DataFailure<TransactionHistoryEntity>) {
          emit(currentState.copyWith(isLoadingMore: false));
        }
      } catch (e) {
        emit(currentState.copyWith(isLoadingMore: false));
      }
    }
  }
}
