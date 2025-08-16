import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/reservations/domain/entities/reservation.dart';
import '/core/network/response.dart';

abstract class IReservationRepo {
  Future<DataState<ReservationEntity>> fetchReservations(FetchReservationParms parms);
  Future<DataState<String>> addUpdateWaiter(AddUpdateWaiterParms parms);
}
