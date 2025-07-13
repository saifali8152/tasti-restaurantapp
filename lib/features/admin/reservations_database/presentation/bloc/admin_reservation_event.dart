import 'package:equatable/equatable.dart';

abstract class AdminReservationEvent extends Equatable {
  const AdminReservationEvent();

  @override
  List<Object?> get props => [];
}

class SearchAdminReservation extends AdminReservationEvent {
  final String search;

  const SearchAdminReservation(this.search);
}
class FetchInitialAdminReservation extends AdminReservationEvent {}
class FetchMoreAdminReservation extends AdminReservationEvent {}