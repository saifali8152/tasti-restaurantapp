import 'package:equatable/equatable.dart';
import '/core/models/pagination.dart';

class EventEntity extends Equatable {
  final List<EventItem> data;
  final PaginationModel pagination;

  const EventEntity({
    required this.data,
    required this.pagination,
  });

  @override
  List<Object?> get props => [data, pagination];
}

class EventItem extends Equatable {
  final int eventId;
  final String eventTitle;
  final String eventImage;
  final String eventLink;

  const EventItem({
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

