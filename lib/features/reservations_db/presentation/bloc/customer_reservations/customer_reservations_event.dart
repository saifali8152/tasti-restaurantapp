import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/csv_data.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/resevation_data.dart';

abstract class CustomerReservationsEvent extends Equatable {
  const CustomerReservationsEvent();

  @override
  List<Object?> get props => [];
}

class FetchCsvDataEvent extends CustomerReservationsEvent {
  final String id;

  const FetchCsvDataEvent(this.id);
}

class FetchReservationDataByEmailEvent extends CustomerReservationsEvent {
  final FetchReservationByEmailParms parms;

  const FetchReservationDataByEmailEvent(this.parms);
}

class FetchReservationEvent extends CustomerReservationsEvent {
  final String id;

  const FetchReservationEvent(this.id);
}

class FetchSmsAvailability extends CustomerReservationsEvent {
  final FetchSmsAvailabilityParms parms;

  const FetchSmsAvailability(this.parms);
}

class ToggleCSVReservationSelectionEvent extends CustomerReservationsEvent {
  final CSVDataEntity reservation;

  const ToggleCSVReservationSelectionEvent(this.reservation);
}

class ToggleReservationSelectionEvent extends CustomerReservationsEvent {
  final ReservationDataEntity reservation;

  const ToggleReservationSelectionEvent(this.reservation);
}
