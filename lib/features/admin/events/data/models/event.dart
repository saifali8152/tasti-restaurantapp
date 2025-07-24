import 'package:tasti_restaurant_app/core/models/pagination.dart';
import 'package:tasti_restaurant_app/features/admin/events/domain/entities/event.dart';

class EventModel extends EventEntity {
  const EventModel({
    required super.data,
    required super.pagination,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      data: List<EventItemModel>.from(
        json['data'].map((item) => EventItemModel.fromJson(item)),
      ),
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => (e as EventItemModel).toJson()).toList(),
      'pagination': (pagination as EventItemModel).toJson(),
    };
  }
}

class EventItemModel extends EventItem {
  const EventItemModel({
    required super.eventId,
    required super.eventTitle,
    required super.eventImage,
    required super.eventLink,
  });

  factory EventItemModel.fromJson(Map<String, dynamic> json) {
    return EventItemModel(
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
