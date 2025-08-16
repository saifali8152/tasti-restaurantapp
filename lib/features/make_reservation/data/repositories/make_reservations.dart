import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/make_reservation/data/data_sources/make_reservation_remote_repo.dart';
import 'package:tasti_restaurant_app/features/make_reservation/domain/entities/restaurant_seating_area.dart';
import 'package:tasti_restaurant_app/features/make_reservation/domain/entities/restaurant_time_slots.dart';
import '../../domain/repositories/make_reservations.dart';
import '/core/network/response.dart';

class MakeReservationRepoImpl extends IMakeReservationRepo {
  final IMakeReservationRemoteApi remote;
  MakeReservationRepoImpl(this.remote);

  @override
  Future<DataState<List<RestaurantSeatingAreaEntity>>> fetchSeatingArea(String id) async {
    try {
      final response = await remote.fetchSeatingArea(id);
      return DataSuccess(response);
    } catch (e) {
      return DataFailure(e.toString());
    }
  }

  @override
  Future<DataState<List<String>>> fetchTables(String id) async {
    try {
      final tables = await remote.fetchTables(id);
      return DataSuccess(tables);
    } catch (e) {
      return DataFailure(e.toString());
    }
  }

  @override
  Future<DataState<RestaurantTimeSlotEntity>> fetchTimeSlots(FetchTimeSlotParms parms) async {
    try {
      final response = await remote.fetchTimeSlots(parms);
      return DataSuccess(response);
    } catch (e) {
      return DataFailure(e.toString());
    }
  }
}
