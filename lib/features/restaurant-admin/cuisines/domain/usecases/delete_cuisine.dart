import '/features/restaurant-admin/cuisines/domain/repositories/cuisines.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class DeleteCuisineUsecase extends UseCase<DataState<String>, String>{
  final ICuisinesRepo repo;
  
  DeleteCuisineUsecase(this.repo);

  @override
  Future<DataState<String>> call(parm) {
    return repo.deleteCuisine(parm);
  }
}