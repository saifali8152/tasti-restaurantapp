// data/models/booking_time_model.dart
import 'package:tasti_restaurant_app/features/manage_booking_time/domain/entities/booking_time.dart';

class BookingTimeModel extends BookingTimeEntity {
  const BookingTimeModel({
    required List<BookingTimeDataModel> data,
    required List<BookingTimeDataModel> active,
    required List<BookingTimeDataModel> inActive,
  }) : super(
          data: data,
          active: active,
          inActive: inActive,
        );

  factory BookingTimeModel.fromJson(Map<String, dynamic> json) {
    return BookingTimeModel(
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => BookingTimeDataModel.fromJson(e))
          .toList(),
      active: (json['active'] as List<dynamic>? ?? [])
          .map((e) => BookingTimeDataModel.fromJson(e))
          .toList(),
      inActive: (json['inActive'] as List<dynamic>? ?? [])
          .map((e) => BookingTimeDataModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => (e as BookingTimeDataModel).toJson()).toList(),
      'active': active.map((e) => (e as BookingTimeDataModel).toJson()).toList(),
      'inActive': inActive.map((e) => (e as BookingTimeDataModel).toJson()).toList(),
    };
  }
}

class BookingTimeDataModel extends BookingTimeDataEntity {
  const BookingTimeDataModel({
    required super.timeId,
    required super.time,
    required super.status,
  });

  factory BookingTimeDataModel.fromJson(Map<String, dynamic> json) {
    return BookingTimeDataModel(
      timeId: json['time_id'] ?? 0,
      time: json['time'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time_id': timeId,
      'time': time,
      'status': status,
    };
  }
}
