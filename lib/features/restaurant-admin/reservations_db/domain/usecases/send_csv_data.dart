import '/core/parms/parms.dart';
import '/features/restaurant-admin/reservations_db/domain/repositories/reservations_db.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class SendCsvDataUsecase extends UseCase<DataState<String>, SendCSVDataParams>{
  final IReservationDbRepo repo;
  
  SendCsvDataUsecase(this.repo);

  @override
  Future<DataState<String>> call(id) {
    return repo.sendCSVData(id);
  }
}