import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/models/pagination.dart';

class TransactionHistoryEntity extends Equatable {
  final List<TransactionHistoryItem> data;
  final PaginationModel pagination;

  const TransactionHistoryEntity({
    required this.data,
    required this.pagination,
  });

  @override
  List<Object?> get props => [data, pagination];
}

class TransactionHistoryItem extends Equatable {
  final int id;
  final int userId;
  final String reference;
  final String amount;
  final String status;
  final String transactionDate;

  const TransactionHistoryItem({
    required this.id,
    required this.userId,
    required this.reference,
    required this.amount,
    required this.status,
    required this.transactionDate,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        reference,
        amount,
        status,
        transactionDate,
      ];
}
