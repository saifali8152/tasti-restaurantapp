import 'package:tasti_restaurant_app/features/admin/requests/domain/repositories/requests_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class DeleteRequestUsecase extends UseCase<DataState<String>, String> {
  final IRequestRepo repo;

  DeleteRequestUsecase(this.repo);

  @override
  Future<DataState<String>> call(parms) {
    return repo.deleteRequest(parms);
  }
}
