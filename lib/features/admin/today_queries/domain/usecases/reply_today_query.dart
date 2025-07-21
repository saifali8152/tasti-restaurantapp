import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/admin/today_queries/domain/repositories/today_queries_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class ReplyTodayQueryUsecase extends UseCase<DataState<String>, ReplyTodayQueryParms> {
  final ITodayQueriesRepo repo;

  ReplyTodayQueryUsecase(this.repo);

  @override
  Future<DataState<String>> call(parms) {
    return repo.replyTodayQuery(parms);
  }
}
