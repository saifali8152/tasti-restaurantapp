import 'package:tasti_restaurant_app/features/bundle_billings/domain/entities/transaction_history.dart';

import '/core/models/pagination.dart';
import '/features/admin/events/domain/entities/event.dart';

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
    required super.eventId,
    required super.eventTitle,
    required super.eventImage,
    required super.eventLink,
  });

  factory RestaurantTransactionHistoryItemModel.fromJson(Map<String, dynamic> json) {
    return RestaurantTransactionHistoryItemModel(
      eventId: json['event_id'] ?? 0,
      eventTitle: json['event_title'] ?? '',
      eventImage: json['event_image'] ?? '',
      eventLink: json['event_link'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'event_title': eventTitle,
      'event_image': eventImage,
      'event_link': eventLink,
    };
  }
}
