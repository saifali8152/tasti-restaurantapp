import 'package:tasti_restaurant_app/core/parms/parms.dart';
import '../entities/reservation.dart';
import '/core/network/response.dart';

abstract class IAdminReservationRepo {
  Future<DataState<AdminReservationEntity>> fetchAdminReservation(PaginationParms parms);
}
