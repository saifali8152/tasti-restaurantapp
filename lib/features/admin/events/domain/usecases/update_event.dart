import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/admin/events/domain/entities/event.dart';
import 'package:tasti_restaurant_app/features/admin/events/domain/repositories/event_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class UpdateEventUsecase extends UseCase<DataState<EventItem>, UpdateEventParms> {
  final IEventRepo repo;

  UpdateEventUsecase(this.repo);

  @override
  Future<DataState<EventItem>> call(parms) {
    return repo.updateEvent(parms);
  }
}
