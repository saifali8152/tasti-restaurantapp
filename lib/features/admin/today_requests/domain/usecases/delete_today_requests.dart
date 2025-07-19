import 'package:tasti_restaurant_app/features/admin/today_requests/domain/repositories/today_requests_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class DeleteTodayRequestUsecase extends UseCase<DataState<String>, String> {
  final ITodayRequestRepo repo;

  DeleteTodayRequestUsecase(this.repo);

  @override
  Future<DataState<String>> call(parms) {
    return repo.deleteTodayRequest(parms);
  }
}
