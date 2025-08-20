import 'package:equatable/equatable.dart';
import '/features/restaurant-admin/make_reservation/domain/entities/restaurant_seating_area.dart';
import '/features/restaurant-admin/make_reservation/domain/entities/restaurant_time_slots.dart';
import '/core/network/response.dart';

class MakeReservationState extends Equatable {
  final ApiResponse<List<RestaurantSeatingAreaEntity>> seatingAreaResponse;
  final ApiResponse<List<String>> tableResponse;
  final ApiResponse<RestaurantTimeSlotEntity> timeSlotResponse;
  final ApiResponse<String> reservationResponse;

  const MakeReservationState({
    required this.seatingAreaResponse,
    required this.tableResponse,
    required this.timeSlotResponse,
    required this.reservationResponse,
  });

  MakeReservationState copyWith({
    final ApiResponse<List<RestaurantSeatingAreaEntity>>? seatingAreaResponse,
    final ApiResponse<List<String>>? tableResponse,
    final ApiResponse<RestaurantTimeSlotEntity>? timeSlotResponse,
    final ApiResponse<String>? reservationResponse,
  }) {
    return MakeReservationState(
      seatingAreaResponse: seatingAreaResponse ?? this.seatingAreaResponse,
      tableResponse: tableResponse ?? this.tableResponse,
      timeSlotResponse: timeSlotResponse ?? this.timeSlotResponse,
      reservationResponse: reservationResponse ?? this.reservationResponse,
    );
  }

  @override
  List<Object?> get props => [
        seatingAreaResponse,
        tableResponse,
        timeSlotResponse,
        reservationResponse,
      ];
}
