import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';

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

class ReplyTodayQuery extends TodayqueriesEvents {
  final ReplyTodayQueryParms parms;

  const ReplyTodayQuery(this.parms);
}

class FetchInitialTodayqueriess extends TodayqueriesEvents {}

class FetchMoreTodayqueriess extends TodayqueriesEvents {}
