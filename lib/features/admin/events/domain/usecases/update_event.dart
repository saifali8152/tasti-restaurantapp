import '/core/parms/parms.dart';
import '/features/admin/events/domain/repositories/event_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class UpdateEventUsecase extends UseCase<DataState<String>, UpdateEventParms> {
  final IEventRepo repo;

  UpdateEventUsecase(this.repo);

  @override
  Future<DataState<String>> call(parms) {
    return repo.updateEvent(parms);
  }
}
