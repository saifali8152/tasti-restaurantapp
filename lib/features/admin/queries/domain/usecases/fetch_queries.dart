import 'package:tasti_restaurant_app/features/admin/queries/domain/entities/queries.dart';
import 'package:tasti_restaurant_app/features/admin/queries/domain/repositories/queries_repo.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/usecase/usecase.dart';

class FetchQueriesUsecase extends UseCase<DataState<QueriesEntity>, QueryParms> {
  final IQueriesRepo repo;

  FetchQueriesUsecase(this.repo);

  @override
  Future<DataState<QueriesEntity>> call(QueryParms parms) {
    return repo.fetchQueries(parms);
  }
}
