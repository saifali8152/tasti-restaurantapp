import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';

abstract class MakeReservationEvent extends Equatable {
  const MakeReservationEvent();

  @override
  List<Object?> get props => [];
}

/// Event to fetch all seating areas of a restaurant
class FetchSeatingAreas extends MakeReservationEvent {
  final String id;

  const FetchSeatingAreas({required this.id});

  @override
  List<Object?> get props => [id];
}

/// Event to fetch available tables for a selected seating area
class FetchTables extends MakeReservationEvent {
  final String id;

  const FetchTables({required this.id});

  @override
  List<Object?> get props => [id];
}

/// Event to fetch available time slots for a table
class FetchTimeSlots extends MakeReservationEvent {
  final FetchTimeSlotParms parms;

  const FetchTimeSlots({
    required this.parms,
  });

  @override
  List<Object?> get props => [parms];
}

/// Event to make a reservation
class MakeReservation extends MakeReservationEvent {
  final MakeReservationParms parms;

  const MakeReservation(this.parms);
}
