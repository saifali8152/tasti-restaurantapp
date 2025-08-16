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

class AddUpdateWaiter extends ReservationEvent {
  final AddUpdateWaiterParms parms;

  const AddUpdateWaiter(this.parms);
}

class UpdateReservationStatus extends ReservationEvent {
  final UpdateReservationStatusParms parms;

  const UpdateReservationStatus(this.parms);
}
class CancelReservation extends ReservationEvent {
  final String id;

  const CancelReservation(this.id);
}