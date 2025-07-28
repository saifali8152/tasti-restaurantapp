import 'package:tasti_restaurant_app/features/common/auth/domain/entities/user.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/domain/repositories/create_restaurant_repo.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/usecase/usecase.dart';

class CreateNewRestaurantUsecase extends UseCase<DataState<UserRestaurantEntity>, CreateRestaurantParms>{
  final ICreateRestaurantRepo repo;
  
  CreateNewRestaurantUsecase(this.repo);

  @override
  Future<DataState<UserRestaurantEntity>> call(CreateRestaurantParms parms) {
    return repo.createRestaurant(parms);
  }
}