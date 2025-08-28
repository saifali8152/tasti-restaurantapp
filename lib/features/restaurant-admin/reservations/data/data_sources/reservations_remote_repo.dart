import '/core/parms/parms.dart';
import '/features/restaurant-admin/reservations/data/models/reservation.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IReservationRemoteApi {
  Future<ReservationModel> fetchReservations(FetchReservationParms parms);
  Future<String> addUpdateWaiter(AddUpdateWaiterParms parms);
  Future<ReservationItemModel> cancelReservation(String id);
  Future<ReservationItemModel> updateReservationStatus(UpdateReservationStatusParms parms);
  Future<ReservationItemModel> updateReservationConfirmation(String id);
}

class ReservationRemoteApiImpl extends IReservationRemoteApi {
  final IApiService networkApiService;
  ReservationRemoteApiImpl(this.networkApiService);

  @override
  Future<ReservationItemModel> updateReservationConfirmation(String id) async {
    var response = await networkApiService.post(
      AppUrls.updateReservationConfirmation,
      {"reservation_id": id},
    );

    return ReservationItemModel.fromJson(response['data']);
  }
  
  @override
  Future<ReservationItemModel> cancelReservation(String id) async {
    var response = await networkApiService.post(
      AppUrls.cancelReservation,
      {"reservation_id": id},
    );

    return ReservationItemModel.fromJson(response['data']);
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
  Future<ReservationItemModel> updateReservationStatus(
      UpdateReservationStatusParms parms) async {
    var response = await networkApiService.post(
      AppUrls.updateReservationStatus,
      {
        "reservation_id": parms.reservationId.toString(),
        "status": parms.status,
      },
    );
    
    return ReservationItemModel.fromJson(response['data']);
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
