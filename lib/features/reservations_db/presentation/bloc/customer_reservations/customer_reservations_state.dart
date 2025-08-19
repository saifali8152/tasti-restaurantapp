import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/csv_data.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/reservation_data_email.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/resevation_data.dart';
import '/core/network/response.dart';

class CustomerReservationsState extends Equatable {
  final ApiResponse<List<CSVDataEntity>> fetchCSVResponse;
  final ApiResponse<List<ReservationDataEntity>> fetchRevervationResponse;
  final ApiResponse<List<ReservationDataEmailEntity>> fetchRevervationByEmailResponse;
  final ApiResponse<String> fetchSmsAvailabilityResponse;
  final List<ReservationDataEntity> selectedRevervations;
  final List<CSVDataEntity> selectedCVCRevervations;

  const CustomerReservationsState({
    required this.fetchCSVResponse,
    required this.fetchRevervationResponse,
    required this.fetchRevervationByEmailResponse,
    required this.fetchSmsAvailabilityResponse,
    required this.selectedCVCRevervations,
    required this.selectedRevervations,
  });

  CustomerReservationsState copyWith({
    final ApiResponse<List<CSVDataEntity>>? fetchCSVResponse,
  final ApiResponse<List<ReservationDataEntity>>? fetchRevervationResponse,
  final ApiResponse<List<ReservationDataEmailEntity>>? fetchRevervationByEmailResponse,
  final ApiResponse<String>? fetchSmsAvailabilityResponse,
  final List<CSVDataEntity>? selectedCVCRevervations,
  final List<ReservationDataEntity>? selectedRevervations,
  }) {
    return CustomerReservationsState(
      fetchCSVResponse: fetchCSVResponse ?? this.fetchCSVResponse,
      fetchRevervationResponse: fetchRevervationResponse ?? this.fetchRevervationResponse,
      fetchRevervationByEmailResponse: fetchRevervationByEmailResponse ?? this.fetchRevervationByEmailResponse,
      fetchSmsAvailabilityResponse: fetchSmsAvailabilityResponse ?? ApiResponse.initial(),
      selectedCVCRevervations: selectedCVCRevervations ?? this.selectedCVCRevervations,
      selectedRevervations: selectedRevervations ?? this.selectedRevervations,
    );
  }

  @override
  List<Object?> get props => [
        fetchCSVResponse,
        fetchRevervationResponse,
        fetchRevervationByEmailResponse,
        fetchSmsAvailabilityResponse,
        selectedCVCRevervations
      ];
}
