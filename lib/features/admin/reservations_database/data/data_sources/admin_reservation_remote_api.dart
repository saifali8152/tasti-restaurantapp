import '/core/parms/parms.dart';
import '/features/admin/reservations_database/data/models/reservation.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IAdminReservationRemoteApi {
  Future<AdminReservationModel> fetchAdminReservation(PaginationParms parms);
}

class AdminReservationRemoteApiImpl extends IAdminReservationRemoteApi {
  final IApiService networkApiService;
  AdminReservationRemoteApiImpl(this.networkApiService);

  @override
  Future<AdminReservationModel> fetchAdminReservation(parms) async {
    final queryParms = {
      "limit": parms.limit,
      "search": parms.search,
      "page": parms.page,
    };
    var response = await networkApiService.get(
      AppUrls.adminReservations,
      queryParams: queryParms,
    );

    final Map<String, dynamic> adminReservation = response;

    final AdminReservationModel dashboard =
        AdminReservationModel.fromJson(adminReservation);
    return dashboard;
  }
}
