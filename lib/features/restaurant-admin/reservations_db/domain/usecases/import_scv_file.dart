import '/core/parms/parms.dart';
import '/features/restaurant-admin/reservations_db/domain/repositories/reservations_db.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class ImportScvFileUsecase extends UseCase<DataState<String>, ImportCSVFileParms>{
  final IReservationDbRepo repo;
  
  ImportScvFileUsecase(this.repo);

  @override
  Future<DataState<String>> call(parms) {
    return repo.importCSVFile(parms);
  }
}