import '/features/admin/queries/data/models/queries.dart';
import '/features/admin/queries/domain/repositories/queries_repo.dart';
import '/core/parms/parms.dart';
import '../data_sources/queries_remote_source.dart';
import '/core/network/response.dart';

class QueriesRepoImpl extends IQueriesRepo {
  final IQueriesRemoteSourceApi dataSource;
  QueriesRepoImpl(this.dataSource);
  
  @override
  Future<DataState<String>> deleteQueries(String id) async{
    try {
      final result = await dataSource.deleteQueries(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
  @override
  Future<DataState<String>> replyQuery(ReplyQueryParms parms) async{
    try {
      final result = await dataSource.replyQuery(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
  @override
  Future<DataState<QueriesModel>> fetchQueries(QueryParms parms) async{
    try {
      final result = await dataSource.fetchQueries(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
