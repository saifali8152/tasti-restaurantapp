import 'package:equatable/equatable.dart';

class BookingTimeEntity extends Equatable {
  final List<BookingTimeDataEntity> data;
  final List<BookingTimeDataEntity> active;
  final List<BookingTimeDataEntity> inActive;

  const BookingTimeEntity({
    required this.data,
    required this.active,
    required this.inActive,
  });

  BookingTimeEntity copyWith({
    List<BookingTimeDataEntity>? data,
    List<BookingTimeDataEntity>? active,
    List<BookingTimeDataEntity>? inActive,
  }) {
    return BookingTimeEntity(
      data: data ?? this.data,
      active: active ?? this.active,
      inActive: inActive ?? this.inActive,
    );
  }

  @override
  List<Object?> get props => [data, active, inActive];
}

class BookingTimeDataEntity extends Equatable {
  final int timeId;
  final String time;
  final String status;

  const BookingTimeDataEntity({
    required this.timeId,
    required this.time,
    required this.status,
  });

  bool get isActive => status.toLowerCase() == 'on';

  BookingTimeDataEntity copyWith({
    int? timeId,
    String? time,
    String? status,
  }) {
    return BookingTimeDataEntity(
      timeId: timeId ?? this.timeId,
      time: time ?? this.time,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [timeId, time, status];
}
