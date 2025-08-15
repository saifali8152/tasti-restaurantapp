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

class RestaurantTransactionHistoryItem extends Equatable {
  final int eventId;
  final String eventTitle;
  final String eventImage;
  final String eventLink;

  const RestaurantTransactionHistoryItem({
    required this.eventId,
    required this.eventTitle,
    required this.eventImage,
    required this.eventLink,
  });

  @override
  List<Object?> get props => [
        eventId,
        eventTitle,
        eventImage,
        eventLink,
      ];
}

