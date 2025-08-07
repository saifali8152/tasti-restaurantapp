import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/domain/entities/cuisine.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/domain/repositories/cuisines.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchCuisineUsecase extends UseCase<DataState<List<CuisineEntity>>, String>{
  final ICuisinesRepo repo;
  
  FetchCuisineUsecase(this.repo);

  @override
  Future<DataState<List<CuisineEntity>>> call(parm) {
    return repo.fetchCuisine(parm);
  }
}