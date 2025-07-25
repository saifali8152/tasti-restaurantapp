import 'package:dio/dio.dart';
import '/features/admin/events/data/models/event.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IEventRemoteSourceApi {
  Future<String> deleteEvent(String id);
  Future<String> addEvent(AddEventParms parms);
  Future<String> updateEvent(UpdateEventParms parms);
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
  Future<String> addEvent(AddEventParms parms) async {
    Map<String, dynamic> data = {};
    Map<String, MultipartFile> files = {};
    if (parms.image.isNotEmpty && !(parms.image.contains("http"))) {
      files = {
        "event_image": await MultipartFile.fromFile(parms.image,
            filename: parms.image.split('/').last),
      };
    }

    data = {
      "event_title": parms.title,
      "event_link": parms.link,
    };

    var response = await networkApiService.postMultipart(
        AppUrls.adminAddEvent, data, files);

    return response['message'];
  }

  @override
  Future<String> updateEvent(UpdateEventParms parms) async {
    Map<String, dynamic> data = {};
    Map<String, MultipartFile> files = {};
    if (parms.image.isNotEmpty && !(parms.image.contains("http"))) {
      files = {
        "event_image": await MultipartFile.fromFile(parms.image,
            filename: parms.image.split('/').last),
      };
    }

    data = {
      "event_id": parms.eventId,
      "event_title": parms.title,
      "event_link": parms.link,
    };

    var response = await networkApiService.postMultipart(
        AppUrls.adminUpdateEvent, data, files);

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
