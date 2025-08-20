import '/features/restaurant-admin/seating_area/domain/entities/seating_area.dart';
import '/features/restaurant-admin/seating_area/domain/repositories/seating_area.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchSeatingAreaUsecase extends UseCase<DataState<List<SeatingAreaEntity>>, String>{
  final ISeatingAreaRepo repo;
  
  FetchSeatingAreaUsecase(this.repo);

  @override
  Future<DataState<List<SeatingAreaEntity>>> call(id) {
    return repo.fetchSeatingAreas(id);
  }
}