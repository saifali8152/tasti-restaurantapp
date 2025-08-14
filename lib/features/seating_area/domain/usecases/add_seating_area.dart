import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/seating_area/domain/repositories/seating_area.dart';
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