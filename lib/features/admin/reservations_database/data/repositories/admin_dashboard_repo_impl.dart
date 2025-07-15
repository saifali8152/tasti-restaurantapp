import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/admin/reservations_database/data/models/reservation.dart';
import '../data_sources/admin_reservation_remote_api.dart';
import '../../domain/repositories/admin_reservation_repo.dart';
import '/core/network/response.dart';

class AdminReservationRepoImpl extends IAdminReservationRepo {
  final IAdminReservationRemoteApi remoteApi;
  AdminReservationRepoImpl(this.remoteApi);

  @override
  Future<DataState<AdminReservationModel>> fetchAdminReservation(PaginationParms parms) async {
    try {
      final result = await remoteApi.fetchAdminReservation(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
