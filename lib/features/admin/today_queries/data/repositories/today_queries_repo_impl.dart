import 'package:tasti_restaurant_app/features/admin/today_queries/data/models/today_queries.dart';
import 'package:tasti_restaurant_app/features/admin/today_queries/domain/repositories/today_queries_repo.dart';
import '/core/parms/parms.dart';
import '../data_sources/today_queries_remote_source.dart';
import '/core/network/response.dart';

class TodayQueriesRepoImpl extends ITodayQueriesRepo {
  final ITodayQueriesRemoteSourceApi dataSource;
  TodayQueriesRepoImpl(this.dataSource);
  
  @override
  Future<DataState<String>> deleteTodayQueries(String id) async{
    try {
      final result = await dataSource.deleteTodayQueries(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
  @override
  Future<DataState<TodayQueriesModel>> fetchTodayQueries(PaginationParms parms) async{
    try {
      final result = await dataSource.fetchTodayQueries(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
