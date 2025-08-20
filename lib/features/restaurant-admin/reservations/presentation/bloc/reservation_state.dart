import 'package:equatable/equatable.dart';
import '/features/restaurant-admin/reservations/domain/entities/reservation.dart';
import '/core/network/response.dart';

class ReservationState extends Equatable {
  final ApiResponse<ReservationEntity> fetchResponse;
  final ApiResponse<String> addUpdateWaiter;
  final ApiResponse<ReservationItem> cancelResponse;
  final ApiResponse<ReservationItem> updateResponse;

  const ReservationState({
    required this.fetchResponse,
    required this.addUpdateWaiter,
    required this.updateResponse,
    required this.cancelResponse,
  });

  ReservationState copyWith({
    final ApiResponse<ReservationEntity>? fetchResponse,
    final ApiResponse<ReservationItem>? cancelResponse,
    final ApiResponse<ReservationItem>? updateResponse,
    final ApiResponse<String>? addUpdateWaiter,
  }) {
    return ReservationState(
      updateResponse: updateResponse ?? this.updateResponse,
      cancelResponse: cancelResponse ?? this.cancelResponse,
      fetchResponse: fetchResponse ?? this.fetchResponse,
      addUpdateWaiter: addUpdateWaiter ?? this.addUpdateWaiter,
    );
  }

  @override
  List<Object?> get props => [
        fetchResponse,
        addUpdateWaiter,
        updateResponse,
        cancelResponse,
      ];
}
