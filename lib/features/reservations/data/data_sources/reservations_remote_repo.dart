import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/reservations/data/models/reservation.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IReservationRemoteApi {
  Future<ReservationModel> fetchReservations(FetchReservationParms parms);
}

class ReservationRemoteApiImpl extends IReservationRemoteApi {
  final IApiService networkApiService;
  ReservationRemoteApiImpl(this.networkApiService);

  @override
  Future<ReservationModel> fetchReservations(
      FetchReservationParms parms) async {
    var response = await networkApiService.get(
      AppUrls.fetchReservations,
      queryParams: {
        "id": parms.id,
        "date": parms.date,
      },
    );

    final ReservationModel reservations = ReservationModel.fromJson(response);
    return reservations;
  }
}
