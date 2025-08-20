import '/core/parms/parms.dart';
import '/features/restaurant-admin/seating_area/domain/repositories/seating_area.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class AddSeatingAreaUsecase extends UseCase<DataState<String>, SeatingAreaParms>{
  final ISeatingAreaRepo repo;
  
  AddSeatingAreaUsecase(this.repo);

  @override
  Future<DataState<String>> call(parm) {
    return repo.addSeatingAreas(parm);
  }
}