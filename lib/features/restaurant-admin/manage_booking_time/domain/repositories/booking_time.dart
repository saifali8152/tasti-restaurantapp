import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/domain/entities/booking_time.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class IBookingTimeRepo {
  Future<DataState<BookingTimeEntity>> fetchTimes(String id);
  Future<DataState<String>> deactivateTime(ActivateDeactivateTimeParms parms);
  Future<DataState<String>> activateTime(ActivateDeactivateTimeParms parms);
  Future<DataState<String>> updateDuration(UpdateDurationParms parms);
}
