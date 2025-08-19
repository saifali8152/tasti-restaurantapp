import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/make_reservation/data/models/restaurant_seating_area.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/make_reservation/data/models/restaurant_time_slots.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IMakeReservationRemoteApi {
  Future<List<RestaurantSeatingAreaModel>> fetchSeatingArea(String id);
  Future<RestaurantTimeSlotModel> fetchTimeSlots(FetchTimeSlotParms parms);
  Future<List<String>> fetchTables(String id);
  Future<String> makeReservation(MakeReservationParms parms);
}

class MakeReservationRemoteApiImpl extends IMakeReservationRemoteApi {
  final IApiService networkApiService;

  MakeReservationRemoteApiImpl(this.networkApiService);

  @override
  Future<String> makeReservation(MakeReservationParms parms) async {
    final response = await networkApiService.post(
      AppUrls.makeReservation,
      {
        "restaurant_id": parms.restaurantId.toString(),
        "date": DateTime.parse(parms.date).toIso8601String().split("T").first,
        "time": parms.time,
        "seating_area_id": parms.seatingAreaId,
        "guests": parms.guests,
        if(parms.guests == "larger_booking")"custom_guests": parms.customGuests,
        "dietary": parms.dietary,
        "occasion": parms.occasion,
        "special_requests": parms.specialRequests,
        "name": parms.name,
        "phone": parms.phone,
      },
    );
    return response['message'];
  }

  @override
  Future<List<RestaurantSeatingAreaModel>> fetchSeatingArea(String id) async {
    final response = await networkApiService.get(
      AppUrls.fetchSeatingAreaForReservation,
      queryParams: {"id": id},
    );

    final seatingAreas = (response['data'] as List)
        .map((e) => RestaurantSeatingAreaModel.fromJson(e))
        .toList();

    return seatingAreas;
  }

  @override
  Future<RestaurantTimeSlotModel> fetchTimeSlots(
      FetchTimeSlotParms parms) async {
    final response = await networkApiService.get(
      AppUrls.fetchTimeSlotByDate,
      queryParams: {
        "id": parms.id.toString(),
        "date": DateTime.parse(parms.date).toIso8601String().split("T").first,
      },
    );

    return RestaurantTimeSlotModel.fromJson(response);
  }

  @override
  Future<List<String>> fetchTables(String id) async {
    final response = await networkApiService.get(
      AppUrls.fetchTablesBySeating,
      queryParams: {"id": id},
    );
    final tables =
        (response['tables'] as List<dynamic>).map((e) => e.toString()).toList();
    return tables;
  }
}
