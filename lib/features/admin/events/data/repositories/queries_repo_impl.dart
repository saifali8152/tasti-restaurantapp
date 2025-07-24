import 'package:tasti_restaurant_app/features/admin/events/data/models/event.dart';
import 'package:tasti_restaurant_app/features/admin/events/domain/repositories/event_repo.dart';
import '/core/parms/parms.dart';
import '../data_sources/event_remote_source.dart';
import '/core/network/response.dart';

class EventRepoImpl extends IEventRepo {
  final IEventRemoteSourceApi dataSource;
  EventRepoImpl(this.dataSource);
  
  @override
  Future<DataState<String>> addEvent(AddEventParms parms) async{
    try {
      final result = await dataSource.addEvent(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
  @override
  Future<DataState<String>> updateEvent(UpdateEventParms parms) async{
    try {
      final result = await dataSource.updateEvent(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
  @override
  Future<DataState<String>> deleteEvent(String id) async{
    try {
      final result = await dataSource.deleteEvent(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
  @override
  Future<DataState<EventModel>> fetchEvents(PaginationParms parms) async{
    try {
      final result = await dataSource.fetchEvents(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
