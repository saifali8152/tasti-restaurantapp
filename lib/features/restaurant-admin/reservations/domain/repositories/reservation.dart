import '/core/parms/parms.dart';
import '/features/restaurant-admin/reservations/domain/entities/reservation.dart';
import '/core/network/response.dart';

abstract class IReservationRepo {
  Future<DataState<ReservationEntity>> fetchReservations(FetchReservationParms parms);
  Future<DataState<String>> addUpdateWaiter(AddUpdateWaiterParms parms);
  Future<DataState<ReservationItem>> cancelReservation(String id);
  Future<DataState<ReservationItem>> updateReservationStatus(UpdateReservationStatusParms parms);
}
