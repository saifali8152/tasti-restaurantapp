import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/domain/repositories/restaurant_user.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class AddRestaurantUserUsecase extends UseCase<DataState<String>, AddRestaurantUserParms>{
  final IRestaurantUserRepo repo;
  
  AddRestaurantUserUsecase(this.repo);

  @override
  Future<DataState<String>> call(parm) {
    return repo.addRestaurantUser(parm);
  }
}