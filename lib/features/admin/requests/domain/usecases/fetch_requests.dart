import '/features/admin/requests/domain/entities/requests.dart';
import '/features/admin/requests/domain/repositories/requests_repo.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/usecase/usecase.dart';

class FetchRequestUsecase extends UseCase<DataState<RequestEntity>, RequestParms> {
  final IRequestRepo repo;

  FetchRequestUsecase(this.repo);

  @override
  Future<DataState<RequestEntity>> call(RequestParms parms) {
    return repo.fetchRequests(parms);
  }
}
