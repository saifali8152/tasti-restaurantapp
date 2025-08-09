import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/features/manage_booking_time/domain/entities/booking_time.dart';
import '/core/network/response.dart';

class BookingTimeState extends Equatable {
  final ApiResponse<BookingTimeEntity> fetchResponse;
  final ApiResponse<String> activateResponse;
  final ApiResponse<String> deactivateResponse;

  const BookingTimeState({
    required this.activateResponse,
    required this.deactivateResponse,
    required this.fetchResponse,
  });

  BookingTimeState copyWith({
    ApiResponse<String>? activateResponse,
    ApiResponse<String>? deactivateResponse,
    ApiResponse<BookingTimeEntity>? fetchResponse,
  }) {
    return BookingTimeState(
      activateResponse: activateResponse ?? ApiResponse.initial(),
      deactivateResponse: deactivateResponse ?? ApiResponse.initial(),
      fetchResponse: fetchResponse ?? this.fetchResponse,
    );
  }

  @override
  List<Object?> get props => [fetchResponse, deactivateResponse, activateResponse];
}
