import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/admin/queries/domain/repositories/queries_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class ReplyQueryUsecase extends UseCase<DataState<String>, ReplyQueryParms> {
  final IQueriesRepo repo;

  ReplyQueryUsecase(this.repo);

  @override
  Future<DataState<String>> call(parms) {
    return repo.replyQuery(parms);
  }
}
