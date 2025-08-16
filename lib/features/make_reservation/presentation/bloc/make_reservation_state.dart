import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/features/make_reservation/domain/entities/restaurant_seating_area.dart';
import 'package:tasti_restaurant_app/features/make_reservation/domain/entities/restaurant_time_slots.dart';
import '/core/network/response.dart';

class MakeReservationState extends Equatable {
  final ApiResponse<List<RestaurantSeatingAreaEntity>> seatingAreaResponse;
  final ApiResponse<List<String>> tableResponse;
  final ApiResponse<RestaurantTimeSlotEntity> timeSlotResponse;

  const MakeReservationState({
    required this.seatingAreaResponse,
    required this.tableResponse,
    required this.timeSlotResponse,
  });

  MakeReservationState copyWith({
    final ApiResponse<List<RestaurantSeatingAreaEntity>>? seatingAreaResponse,
    final ApiResponse<List<String>>? tableResponse,
    final ApiResponse<RestaurantTimeSlotEntity>? timeSlotResponse,
  }) {
    return MakeReservationState(
      seatingAreaResponse: seatingAreaResponse ?? this.seatingAreaResponse,
      tableResponse: tableResponse ?? this.tableResponse,
      timeSlotResponse: timeSlotResponse ?? this.timeSlotResponse,
    );
  }

  @override
  List<Object?> get props => [
        seatingAreaResponse,
        tableResponse,
        timeSlotResponse,
      ];
}
