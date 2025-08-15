import 'package:equatable/equatable.dart';
import '/core/models/pagination.dart';

class ReataurantTransactionHistoryEntity extends Equatable {
  final List<RestaurantTransactionHistoryItem> data;
  final PaginationModel pagination;

  const ReataurantTransactionHistoryEntity({
    required this.data,
    required this.pagination,
  });

  @override
  List<Object?> get props => [data, pagination];
}

class RestaurantTransactionHistoryItem {
  final int id;
  final String reference;
  final String amount;
  final String status;
  final String date;

  const RestaurantTransactionHistoryItem({
    required this.id,
    required this.reference,
    required this.amount,
    required this.status,
    required this.date,
  });
}

