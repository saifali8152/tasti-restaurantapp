import '/core/parms/parms.dart';
import '/features/restaurant-admin/reservations_db/domain/entities/reservation_data_email.dart';
import '/features/restaurant-admin/reservations_db/domain/repositories/reservations_db.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchReservationDataByEmailUsecase extends UseCase<DataState<List<ReservationDataEmailEntity>>, FetchReservationByEmailParms>{
  final IReservationDbRepo repo;
  
  FetchReservationDataByEmailUsecase(this.repo);

  @override
  Future<DataState<List<ReservationDataEmailEntity>>> call(parms) {
    return repo.fetchReservationsByEmail(parms);
  }
}