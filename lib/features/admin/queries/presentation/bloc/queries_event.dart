import 'package:equatable/equatable.dart';
import '/core/enum/query_type.dart';
import '/core/parms/parms.dart';

abstract class QueriesEvents extends Equatable {
  const QueriesEvents();

  @override
  List<Object?> get props => [];
}

class AdminDeleteQueries extends QueriesEvents {
  final int id;

  const AdminDeleteQueries(this.id);
}

class SearchQueriess extends QueriesEvents {
  final String query;
  final QueryType type;

  const SearchQueriess(this.query, this.type);
}

class ReplyQuery extends QueriesEvents {
  final ReplyQueryParms parms;

  const ReplyQuery(this.parms);
}

class FetchInitialQueries extends QueriesEvents {
  final QueryType type;

  const FetchInitialQueries({required this.type});

  @override
  List<Object?> get props => [type];
}

class FetchMoreQueries extends QueriesEvents {
  final QueryType type;

  const FetchMoreQueries({required this.type});

  @override
  List<Object?> get props => [type];
}
