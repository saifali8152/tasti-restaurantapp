import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/make_reservation/domain/entities/restaurant_seating_area.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/make_reservation/domain/entities/restaurant_time_slots.dart';
import '/core/network/response.dart';

abstract class IMakeReservationRepo {
  Future<DataState<List<RestaurantSeatingAreaEntity>>> fetchSeatingArea(String id);
  Future<DataState<RestaurantTimeSlotEntity>> fetchTimeSlots(FetchTimeSlotParms parms);
  Future<DataState<List<String>>> fetchTables(String id);
  Future<DataState<String>> makeReservation(MakeReservationParms parms);
}
