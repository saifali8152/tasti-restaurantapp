import 'package:tasti_restaurant_app/features/admin/events/domain/entities/event.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class IEventRepo {
  Future<DataState<String>> deleteEvent(String id);
  Future<DataState<EventEntity>> fetchEvents(PaginationParms parms);
}
