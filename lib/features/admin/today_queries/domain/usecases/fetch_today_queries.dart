import 'package:tasti_restaurant_app/features/admin/today_queries/domain/entities/today_queries.dart';
import 'package:tasti_restaurant_app/features/admin/today_queries/domain/repositories/today_queries_repo.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/usecase/usecase.dart';

class FetchTodayQueriesUsecase extends UseCase<DataState<TodayQueriesEntity>, PaginationParms> {
  final ITodayQueriesRepo repo;

  FetchTodayQueriesUsecase(this.repo);

  @override
  Future<DataState<TodayQueriesEntity>> call(PaginationParms parms) {
    return repo.fetchTodayQueries(parms);
  }
}
