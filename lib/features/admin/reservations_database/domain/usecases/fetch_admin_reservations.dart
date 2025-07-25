import '/core/parms/parms.dart';
import '/features/admin/reservations_database/domain/repositories/admin_reservation_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';
import '../entities/reservation.dart';

class FetchAdminReservationsUseCase extends UseCase<DataState<AdminReservationEntity>, PaginationParms>{
  final IAdminReservationRepo repo;
  
  FetchAdminReservationsUseCase(this.repo);

  @override
  Future<DataState<AdminReservationEntity>> call(parms) {
    return repo.fetchAdminReservation(parms);
  }
}