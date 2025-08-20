import '/features/restaurant-admin/reservations_db/domain/entities/resevation_data.dart';
import '/features/restaurant-admin/reservations_db/domain/repositories/reservations_db.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchReservationDataUsecase extends UseCase<DataState<List<ReservationDataEntity>>, String>{
  final IReservationDbRepo repo;
  
  FetchReservationDataUsecase(this.repo);

  @override
  Future<DataState<List<ReservationDataEntity>>> call(id) {
    return repo.fetchReservations(id);
  }
}