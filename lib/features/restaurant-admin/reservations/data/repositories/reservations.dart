import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations/data/data_sources/reservations_remote_repo.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations/data/models/reservation.dart';
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
