import 'package:tasti_restaurant_app/features/restaurant-admin/reservations/domain/entities/reservation.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations/domain/repositories/reservation.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class CancelReservationsUsecase extends UseCase<DataState<ReservationItem>, String>{
  final IReservationRepo repo;
  
  CancelReservationsUsecase(this.repo);

  @override
  Future<DataState<ReservationItem>> call(parms) {
    return repo.cancelReservation(parms);
  }
}