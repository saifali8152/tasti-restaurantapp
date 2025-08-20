import '/core/parms/parms.dart';
import '/features/restaurant-admin/reservations/domain/entities/reservation.dart';
import '/features/restaurant-admin/reservations/domain/repositories/reservation.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class UpdateReservationsStatusUsecase extends UseCase<DataState<ReservationItem>, UpdateReservationStatusParms>{
  final IReservationRepo repo;
  
  UpdateReservationsStatusUsecase(this.repo);

  @override
  Future<DataState<ReservationItem>> call(parms) {
    return repo.updateReservationStatus(parms);
  }
}