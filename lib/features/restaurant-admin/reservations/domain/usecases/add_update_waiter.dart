import '/core/parms/parms.dart';
import '/features/restaurant-admin/reservations/domain/repositories/reservation.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class AddUpdateWaiterUsecase extends UseCase<DataState<String>, AddUpdateWaiterParms>{
  final IReservationRepo repo;
  
  AddUpdateWaiterUsecase(this.repo);

  @override
  Future<DataState<String>> call(parms) {
    return repo.addUpdateWaiter(parms);
  }
}