import 'package:tasti_restaurant_app/features/admin/events/domain/entities/event.dart';
import 'package:tasti_restaurant_app/features/admin/events/domain/repositories/event_repo.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/usecase/usecase.dart';

class FetchEventsUsecase extends UseCase<DataState<EventEntity>, PaginationParms> {
  final IEventRepo repo;

  FetchEventsUsecase(this.repo);

  @override
  Future<DataState<EventEntity>> call(PaginationParms parms) {
    return repo.fetchEvents(parms);
  }
}
