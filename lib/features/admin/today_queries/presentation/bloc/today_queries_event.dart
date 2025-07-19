import 'package:equatable/equatable.dart';

abstract class TodayqueriesEvents extends Equatable {
  const TodayqueriesEvents();

  @override
  List<Object?> get props => [];
}

class AdminDeleteTodayqueries extends TodayqueriesEvents {
  final int id;

  const AdminDeleteTodayqueries(this.id);
}

class SearchTodayqueriess extends TodayqueriesEvents {
  final String query;

  const SearchTodayqueriess(this.query);
}

class FetchInitialTodayqueriess extends TodayqueriesEvents {}

class FetchMoreTodayqueriess extends TodayqueriesEvents {}
