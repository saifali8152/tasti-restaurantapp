import '/core/models/pagination.dart';
import '/features/admin/transaction_history/domain/entities/transaction_history.dart';

abstract class TransactionHistoryState {}

class FetchTransactionHistoryInitial extends TransactionHistoryState {}
class FetchTransactionHistoryLoading extends TransactionHistoryState {}

class FetchTransactionHistoryLoaded extends TransactionHistoryState {
  final List<TransactionHistoryItem> data;
  final PaginationModel pagination;
  final bool isLoadingMore;

  FetchTransactionHistoryLoaded({
    required this.data,
    required this.pagination,
    this.isLoadingMore = false,
  });

  FetchTransactionHistoryLoaded copyWith({
    List<TransactionHistoryItem>? data,
    PaginationModel? pagination,
    bool? isLoadingMore,
  }) {
    return FetchTransactionHistoryLoaded(
      data: data ?? this.data,
      pagination: pagination ?? this.pagination,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class FetchTransactionHistoryError extends TransactionHistoryState {
  final String message;

  FetchTransactionHistoryError(this.message);
}
