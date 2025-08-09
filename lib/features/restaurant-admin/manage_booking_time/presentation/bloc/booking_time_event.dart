import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';

abstract class BookingTimeEvent extends Equatable {
  const BookingTimeEvent();

  @override
  List<Object?> get props => [];
}
class FetchBookingTimeEvent extends BookingTimeEvent {
  final String id;

  const FetchBookingTimeEvent(this.id);
}

class ActivateBookingTimeEvent extends BookingTimeEvent {
  final ActivateDeactivateTimeParms parms;

  const ActivateBookingTimeEvent(this.parms);
}

class DeactivateBookingTimeEvent extends BookingTimeEvent {
  final ActivateDeactivateTimeParms parms;

  const DeactivateBookingTimeEvent(this.parms);
}

class UpdateDurationTimeEvent extends BookingTimeEvent {
  final UpdateDurationParms parms;

  const UpdateDurationTimeEvent(this.parms);
}
