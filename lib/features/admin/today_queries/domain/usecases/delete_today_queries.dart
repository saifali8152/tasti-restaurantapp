import 'package:tasti_restaurant_app/features/admin/today_queries/domain/repositories/today_queries_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class DeleteTodayQueriesUsecase extends UseCase<DataState<String>, String> {
  final ITodayQueriesRepo repo;

  DeleteTodayQueriesUsecase(this.repo);

  @override
  Future<DataState<String>> call(parms) {
    return repo.deleteTodayQueries(parms);
  }
}
