import 'package:tasti_restaurant_app/features/admin/events/data/models/event.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IEventRemoteSourceApi {
  Future<String> deleteEvent(String id);
  Future<EventModel> fetchEvents(PaginationParms parms);

}

class EventSourceRemoteApiImpl extends IEventRemoteSourceApi {
  final IApiService networkApiService;
  EventSourceRemoteApiImpl(this.networkApiService);

  @override
  Future<String> deleteEvent(String id) async {
    Map<String, dynamic> data = {};

    data = {
      "event_id": id,
    };
    var response = await networkApiService.post(AppUrls.adminDeleteEvent, data);

    return response['message'];
  }
 
  @override
  Future<EventModel> fetchEvents(PaginationParms parms) async {
    Map<String, String> data = {};
    String url = AppUrls.adminFetchEvents;

    data = {
      "page": parms.page.toString(),
      "limit": parms.limit.toString(),
      "search": parms.search.toString(),
    };
    final response = await networkApiService.get(url, queryParams: data);
    final Map<String, dynamic> adminReservation = response;
    final EventModel adminSmsList = EventModel.fromJson(adminReservation);
    return adminSmsList;
  }
}
