import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/features/reservations/domain/entities/reservation.dart';
import '/core/network/response.dart';

class ReservationState extends Equatable {
  final ApiResponse<ReservationEntity> fetchResponse;

  const ReservationState({required this.fetchResponse});

  ReservationState copyWith({
    final ApiResponse<ReservationEntity>? fetchResponse,
  }) {
    return ReservationState(
      fetchResponse: fetchResponse ?? this.fetchResponse,
    );
  }

  @override
  List<Object?> get props => [fetchResponse];
}
