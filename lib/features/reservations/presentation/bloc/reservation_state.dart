import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/features/reservations/domain/entities/reservation.dart';
import '/core/network/response.dart';

class ReservationState extends Equatable {
  final ApiResponse<ReservationEntity> fetchResponse;
  final ApiResponse<String> addUpdateWaiter;

  const ReservationState({
    required this.fetchResponse,
    required this.addUpdateWaiter,
  });

  ReservationState copyWith({
    final ApiResponse<ReservationEntity>? fetchResponse,
    final ApiResponse<String>? addUpdateWaiter,
  }) {
    return ReservationState(
      fetchResponse: fetchResponse ?? this.fetchResponse,
      addUpdateWaiter: addUpdateWaiter ?? this.addUpdateWaiter,
    );
  }

  @override
  List<Object?> get props => [fetchResponse, addUpdateWaiter];
}
