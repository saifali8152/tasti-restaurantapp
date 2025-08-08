import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/data/models/working_hour.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IWorkingHourRemoteApi {
  Future<WorkingHourModel> fetchWorkingHours(String id);
  Future<String> updateWorkingHours(UpdateWorkingHourParms parms);
  Future<String> addWorkingHours(AddWorkingHourParms parms);
}

class WorkingHourRemoteApiImpl extends IWorkingHourRemoteApi {
  final IApiService networkApiService;
  WorkingHourRemoteApiImpl(this.networkApiService);

  @override
  Future<String> addWorkingHours(AddWorkingHourParms parms) async {
    Map<String, String> data = {
      "restaurant_id": parms.id.toString(),
      "monday": parms.monday,
      "tuesday": parms.tuesday,
      "wednesday": parms.wednesday,
      "thursday": parms.thursday,
      "friday": parms.friday,
      "saturday": parms.saturday,
      "sunday": parms.sunday,
    };

    var response = await networkApiService.post(AppUrls.addWorkingHours, data);
    return response['message'];
  }

  @override
  Future<WorkingHourModel> fetchWorkingHours(String id) async {
    Map<String, String> data = {"id": id};

    var response = await networkApiService.get(
      AppUrls.fetchWorkingHours,
      queryParams: data,
    );
    final WorkingHourModel workingHour =
        WorkingHourModel.fromJson(response['data']);
    return workingHour;
  }

  @override
  Future<String> updateWorkingHours(UpdateWorkingHourParms parms) async {
    Map<String, String> data = {
      "restaurant_id": parms.id.toString(),
      "monday": parms.monday,
      "tuesday": parms.tuesday,
      "wednesday": parms.wednesday,
      "thursday": parms.thursday,
      "friday": parms.friday,
      "saturday": parms.saturday,
      "sunday": parms.sunday,
    };

    var response =
        await networkApiService.post(AppUrls.updateWorkingHours, data);
    final workingHour = response['message'];
    return workingHour;
  }
}
