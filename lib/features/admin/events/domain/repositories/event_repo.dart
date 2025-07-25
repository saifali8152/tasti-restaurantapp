import '/features/admin/events/domain/entities/event.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class IEventRepo {
  Future<DataState<String>> deleteEvent(String id);
  Future<DataState<String>> addEvent(AddEventParms parms);
  Future<DataState<String>> updateEvent(UpdateEventParms parms);
  Future<DataState<EventEntity>> fetchEvents(PaginationParms parms);
}
