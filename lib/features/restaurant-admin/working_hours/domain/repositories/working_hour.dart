import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/domain/entities/working_hour.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class IWorkingHourRepo {
  Future<DataState<WorkingHourEntity>> fetchWorkingHours(String id);
  Future<DataState<String>> updateWorkingHours(UpdateWorkingHourParms parms);
  Future<DataState<String>> addWorkingHours(AddWorkingHourParms parms);
}
