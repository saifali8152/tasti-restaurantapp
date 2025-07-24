import 'package:tasti_restaurant_app/features/admin/queries/domain/entities/queries.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class IQueriesRepo {
  Future<DataState<QueriesEntity>> fetchQueries(QueryParms parms);
  Future<DataState<String>> deleteQueries(String id);
  Future<DataState<String>> replyQuery(ReplyQueryParms parms);
}
