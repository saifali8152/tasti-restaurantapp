import '/features/restaurant-admin/reservations_db/domain/entities/csv_data.dart';
import '/features/restaurant-admin/reservations_db/domain/repositories/reservations_db.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchCsvDataUsecase extends UseCase<DataState<List<CSVDataEntity>>, String>{
  final IReservationDbRepo repo;
  
  FetchCsvDataUsecase(this.repo);

  @override
  Future<DataState<List<CSVDataEntity>>> call(id) {
    return repo.fetchCSVData(id);
  }
}