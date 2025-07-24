import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';

abstract class EventEvents extends Equatable {
  const EventEvents();

  @override
  List<Object?> get props => [];
}

class AdminDeleteEvent extends EventEvents {
  final int id;

  const AdminDeleteEvent(this.id);
}

class SearchEvents extends EventEvents {
  final String query;

  const SearchEvents(this.query);
}

class AddEvent extends EventEvents {
  final AddEventParms parms;

  const AddEvent(this.parms);
}

class FetchInitialEvent extends EventEvents {}

class FetchMoreEvent extends EventEvents {}
