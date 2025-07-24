import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/admin/events/domain/entities/event.dart';
import 'package:tasti_restaurant_app/features/admin/events/domain/repositories/event_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class AddEventUsecase extends UseCase<DataState<EventItem>, AddEventParms> {
  final IEventRepo repo;

  AddEventUsecase(this.repo);

  @override
  Future<DataState<EventItem>> call(parms) {
    return repo.addEvent(parms);
  }
}
