import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/data/models/booking_time.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IBookingTimeRemoteApi {
  Future<BookingTimeModel> fetchTimes(String id);
  Future<String> deactivateTime(ActivateDeactivateTimeParms parms);
  Future<String> activateTime(ActivateDeactivateTimeParms id);
  Future<String> updateTimeDuration(UpdateDurationParms id);
}

class BookingTimeRemoteApiImpl extends IBookingTimeRemoteApi {
  final IApiService networkApiService;
  BookingTimeRemoteApiImpl(this.networkApiService);

  @override
  Future<BookingTimeModel> fetchTimes(String id) async {
    var response = await networkApiService.get(AppUrls.fetchTimes, queryParams: {'id': id});
    return BookingTimeModel.fromJson(response);
  }

  @override
  Future<String> deactivateTime(ActivateDeactivateTimeParms parms) async {
    Map<String, String> data = {
      "id": parms.id.toString(),
      "time_id": parms.timeId.toString(),
    };

    var response = await networkApiService.post(AppUrls.deactivateTime, data);
    return response['message'];
  }

  @override
  Future<String> activateTime(ActivateDeactivateTimeParms parms) async {
    Map<String, String> data = {
      "id": parms.id.toString(),
      "time_id": parms.timeId.toString(),
    };

    var response = await networkApiService.post(AppUrls.activateTime, data);
    return response['message'];
  }
  
  @override
  Future<String> updateTimeDuration(UpdateDurationParms parms) async {
    Map<String, String> data = {
      "id": parms.id.toString(),
      "time_duration": parms.timeDuration.toString(),
    };

    var response = await networkApiService.post(AppUrls.updateDuration, data);
    return response['message'];
  }
}
