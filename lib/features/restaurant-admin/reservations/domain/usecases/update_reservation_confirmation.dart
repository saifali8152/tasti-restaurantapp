import '/features/restaurant-admin/reservations/domain/entities/reservation.dart';
import '/features/restaurant-admin/reservations/domain/repositories/reservation.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class UpdateReservationConfirmationUsecase extends UseCase<DataState<ReservationItem>, String>{
  final IReservationRepo repo;
  
  UpdateReservationConfirmationUsecase(this.repo);

  @override
  Future<DataState<ReservationItem>> call(parms) {
    return repo.updateReservationConfirmation(parms);
  }
}