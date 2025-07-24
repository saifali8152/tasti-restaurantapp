import 'package:equatable/equatable.dart';

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

class FetchInitialEvent extends EventEvents {}

class FetchMoreEvent extends EventEvents {}
