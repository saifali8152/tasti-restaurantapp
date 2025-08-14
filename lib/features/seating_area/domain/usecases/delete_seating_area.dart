import 'package:tasti_restaurant_app/features/seating_area/domain/repositories/seating_area.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class DeleteSeatingAreaUsecase extends UseCase<DataState<String>, String>{
  final ISeatingAreaRepo repo;
  
  DeleteSeatingAreaUsecase(this.repo);

  @override
  Future<DataState<String>> call(id) {
    return repo.deleteSeatingArea(id);
  }
}