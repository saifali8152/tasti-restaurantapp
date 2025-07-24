import 'package:tasti_restaurant_app/features/admin/events/domain/repositories/event_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class DeleteEventUsecase extends UseCase<DataState<String>, String> {
  final IEventRepo repo;

  DeleteEventUsecase(this.repo);

  @override
  Future<DataState<String>> call(parms) {
    return repo.deleteEvent(parms);
  }
}
