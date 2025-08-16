import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/reservations/data/data_sources/reservations_remote_repo.dart';
import 'package:tasti_restaurant_app/features/reservations/data/models/reservation.dart';
import '../../domain/repositories/reservation.dart';
import '/core/network/response.dart';

class ReservationRepoImpl extends IReservationRepo {
  final IReservationRemoteApi remote;
  ReservationRepoImpl(this.remote);

  @override
  Future<DataState<ReservationModel>> fetchReservations(FetchReservationParms parms) async {
    try {
      final result = await remote.fetchReservations(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
 
  @override
  Future<DataState<String>> addUpdateWaiter(AddUpdateWaiterParms parms) async {
    try {
      final result = await remote.addUpdateWaiter(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
