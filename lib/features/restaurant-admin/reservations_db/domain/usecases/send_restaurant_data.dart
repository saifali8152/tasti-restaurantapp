import '/core/parms/parms.dart';
import '/features/restaurant-admin/reservations_db/domain/repositories/reservations_db.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class SendRestaurantDataUsecase extends UseCase<DataState<String>, SendRestaurantDataParms>{
  final IReservationDbRepo repo;
  
  SendRestaurantDataUsecase(this.repo);

  @override
  Future<DataState<String>> call(id) {
    return repo.sendRestaurantData(id);
  }
}