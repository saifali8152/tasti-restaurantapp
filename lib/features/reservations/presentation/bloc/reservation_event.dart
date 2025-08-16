import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();

  @override
  List<Object?> get props => [];
}

class FetchReservationEvent extends ReservationEvent {
  final FetchReservationParms parms;

  const FetchReservationEvent(this.parms);
}