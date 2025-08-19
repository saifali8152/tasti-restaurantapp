import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations/domain/entities/reservation.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations/domain/repositories/reservation.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchReservationsUsecase extends UseCase<DataState<ReservationEntity>, FetchReservationParms>{
  final IReservationRepo repo;
  
  FetchReservationsUsecase(this.repo);

  @override
  Future<DataState<ReservationEntity>> call(parms) {
    return repo.fetchReservations(parms);
  }
}