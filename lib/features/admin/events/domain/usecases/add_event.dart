import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/admin/events/domain/repositories/event_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class AddEventUsecase extends UseCase<DataState<String>, AddEventParms> {
  final IEventRepo repo;

  AddEventUsecase(this.repo);

  @override
  Future<DataState<String>> call(parms) {
    return repo.addEvent(parms);
  }
}
