import '/core/parms/parms.dart';
import '/features/restaurant-admin/reservations/data/data_sources/reservations_remote_repo.dart';
import '/features/restaurant-admin/reservations/data/models/reservation.dart';
import '../../domain/repositories/reservation.dart';
import '/core/network/response.dart';

class ReservationRepoImpl extends IReservationRepo {
  final IReservationRemoteApi remote;
  ReservationRepoImpl(this.remote);

  @override
  Future<DataState<ReservationItemModel>> updateReservationStatus(UpdateReservationStatusParms parms) async {
    try {
      final result = await remote.updateReservationStatus(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<ReservationItemModel>> updateReservationConfirmation(String id) async {
    try {
      final result = await remote.updateReservationConfirmation(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
  @override
  Future<DataState<ReservationItemModel>> cancelReservation(String id) async {
    try {
      final result = await remote.cancelReservation(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
 
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
