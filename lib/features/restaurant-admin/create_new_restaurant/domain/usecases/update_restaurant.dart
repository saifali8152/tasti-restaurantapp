import 'package:tasti_restaurant_app/features/common/auth/domain/entities/user.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/domain/repositories/create_restaurant_repo.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/usecase/usecase.dart';

class UpdateRestaurantUsecase extends UseCase<DataState<UserRestaurantEntity>, UpdateRestaurantParms>{
  final ICreateRestaurantRepo repo;
  
  UpdateRestaurantUsecase(this.repo);

  @override
  Future<DataState<UserRestaurantEntity>> call(UpdateRestaurantParms parms) {
    return repo.updateRestaurant(parms);
  }
}