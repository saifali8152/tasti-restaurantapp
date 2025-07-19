import 'package:tasti_restaurant_app/features/admin/today_queries/domain/entities/today_queries.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class ITodayQueriesRepo {
  Future<DataState<TodayQueriesEntity>> fetchTodayQueries(PaginationParms parms);
  Future<DataState<String>> deleteTodayQueries(String id);
}
