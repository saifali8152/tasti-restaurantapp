import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/domain/entities/transaction_history.dart';
import '/core/models/pagination.dart';

class RestaurantTransactionHistoryModel extends ReataurantTransactionHistoryEntity {
  const RestaurantTransactionHistoryModel({
    required super.data,
    required super.pagination,
  });

  factory RestaurantTransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    return RestaurantTransactionHistoryModel(
      data: List<RestaurantTransactionHistoryItemModel>.from(
        json['data'].map((item) => RestaurantTransactionHistoryItemModel.fromJson(item)),
      ),
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => (e as RestaurantTransactionHistoryItemModel).toJson()).toList(),
      'pagination': (pagination as RestaurantTransactionHistoryItemModel).toJson(),
    };
  }
}

class RestaurantTransactionHistoryItemModel extends RestaurantTransactionHistoryItem {
  const RestaurantTransactionHistoryItemModel({
    required super.id,
    required super.reference,
    required super.amount,
    required super.status,
    required super.date,
  });

  factory RestaurantTransactionHistoryItemModel.fromJson(Map<String, dynamic> json) {
    return RestaurantTransactionHistoryItemModel(
      id: json['id'] ?? 0,
      reference: json['reference'] ?? '',
      amount: json['amount'] ?? '',
      status: json['status'] ?? '',
      date: json['transaction_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference': reference,
      'amount': amount,
      'status': status,
      'transaction_date': date,
    };
  }
}
