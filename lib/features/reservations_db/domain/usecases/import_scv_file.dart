import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/repositories/reservations_db.dart';
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