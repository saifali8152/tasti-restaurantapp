import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';

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