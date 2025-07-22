import 'package:tasti_restaurant_app/features/admin/queries/domain/repositories/queries_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class DeleteQueriesUsecase extends UseCase<DataState<String>, String> {
  final IQueriesRepo repo;

  DeleteQueriesUsecase(this.repo);

  @override
  Future<DataState<String>> call(parms) {
    return repo.deleteQueries(parms);
  }
}
