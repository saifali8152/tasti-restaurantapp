import 'package:equatable/equatable.dart';
import '/features/restaurant-admin/reservations/domain/entities/reservation.dart';
import '/core/network/response.dart';

class ReservationState extends Equatable {
  final ApiResponse<ReservationEntity> fetchResponse;
  final ApiResponse<String> addUpdateWaiter;
  final ApiResponse<ReservationItem> cancelResponse;
  final ApiResponse<ReservationItem> updateResponse;
  final ApiResponse<ReservationItem> updateConfirmationResponse;

  const ReservationState({
    required this.fetchResponse,
    required this.addUpdateWaiter,
    required this.updateResponse,
    required this.updateConfirmationResponse,
    required this.cancelResponse,
  });

  ReservationState copyWith({
    final ApiResponse<ReservationEntity>? fetchResponse,
    final ApiResponse<ReservationItem>? cancelResponse,
    final ApiResponse<ReservationItem>? updateResponse,
    final ApiResponse<ReservationItem>? updateConfirmationResponse,
    final ApiResponse<String>? addUpdateWaiter,
  }) {
    return ReservationState(
      updateResponse: updateResponse ?? this.updateResponse,
      updateConfirmationResponse: updateConfirmationResponse ?? this.updateConfirmationResponse,
      cancelResponse: cancelResponse ?? this.cancelResponse,
      fetchResponse: fetchResponse ?? this.fetchResponse,
      addUpdateWaiter: addUpdateWaiter ?? ApiResponse.initial(),
    );
  }

  @override
  List<Object?> get props => [
        fetchResponse,
        addUpdateWaiter,
        updateResponse,
        updateConfirmationResponse,
        cancelResponse,
      ];
}
