import 'package:tasti_restaurant_app/features/admin/today_requests/domain/entities/requests.dart';
import 'package:tasti_restaurant_app/features/admin/today_requests/domain/repositories/today_requests_repo.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/usecase/usecase.dart';

class FetchTodayRequestUsecase extends UseCase<DataState<RequestEntity>, RequestParms> {
  final ITodayRequestRepo repo;

  FetchTodayRequestUsecase(this.repo);

  @override
  Future<DataState<RequestEntity>> call(RequestParms parms) {
    return repo.fetchTodayRequests(parms);
  }
}
