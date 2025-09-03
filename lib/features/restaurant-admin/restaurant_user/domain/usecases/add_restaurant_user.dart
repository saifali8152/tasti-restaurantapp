import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/domain/entities/restaurant_user.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/domain/repositories/restaurant_user.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class AddRestaurantUserUsecase extends UseCase<DataState<RestaurantUserEntity>, AddRestaurantUserParms>{
  final IRestaurantUserRepo repo;
  
  AddRestaurantUserUsecase(this.repo);

  @override
  Future<DataState<RestaurantUserEntity>> call(parm) {
    return repo.addRestaurantUser(parm);
  }
}