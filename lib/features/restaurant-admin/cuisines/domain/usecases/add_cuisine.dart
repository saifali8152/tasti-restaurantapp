import '/core/parms/parms.dart';
import '/features/restaurant-admin/cuisines/domain/repositories/cuisines.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class AddCuisineUsecase extends UseCase<DataState<String>, AddCuisineParms>{
  final ICuisinesRepo repo;
  
  AddCuisineUsecase(this.repo);

  @override
  Future<DataState<String>> call(parm) {
    return repo.addCuisine(parm);
  }
}