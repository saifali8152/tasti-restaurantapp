import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/reservations/data/models/reservation.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IReservationRemoteApi {
  Future<ReservationModel> fetchReservations(FetchReservationParms parms);
  Future<String> addUpdateWaiter(AddUpdateWaiterParms parms);
  Future<String> cancelReservation(String id);
  Future<String> updateReservationStatus(UpdateReservationStatusParms parms);
}

class ReservationRemoteApiImpl extends IReservationRemoteApi {
  final IApiService networkApiService;
  ReservationRemoteApiImpl(this.networkApiService);

  @override
  Future<String> cancelReservation(String id) async {
    var response = await networkApiService.post(
      AppUrls.cancelReservation,
      {"reservation_id": id},
    );

    return response['message'];
  }

  @override
  Future<ReservationModel> fetchReservations(
      FetchReservationParms parms) async {
    var response = await networkApiService.get(
      AppUrls.fetchReservations,
      queryParams: {
        "id": parms.id,
        "date": DateTime.parse(parms.date).toIso8601String().split("T").first,
      },
    );

    final ReservationModel reservations = ReservationModel.fromJson(response);
    return reservations;
  }
  
  @override
  Future<String> updateReservationStatus(
      UpdateReservationStatusParms parms) async {
    var response = await networkApiService.post(
      AppUrls.updateReservationStatus,
      {
        "reservation_id": parms.reservationId.toString(),
        "status": parms.status,
      },
    );

    return response['message'];
  }

  @override
  Future<String> addUpdateWaiter(AddUpdateWaiterParms parms) async {
    var response = await networkApiService.post(AppUrls.assignWaiter, {
      "reservation_id": parms.reservationId,
      "waiter_name": parms.waiterName,
    });

    return response['message'];
  }
}
