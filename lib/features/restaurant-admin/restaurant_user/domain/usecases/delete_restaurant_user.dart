import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/domain/repositories/restaurant_user.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class DeleteRestaurantUserUsecase extends UseCase<DataState<String>, DeleteRestaurantUserParms>{
  final IRestaurantUserRepo repo;
  
  DeleteRestaurantUserUsecase(this.repo);

  @override
  Future<DataState<String>> call(id) {
    return repo.deleteRestaurantUser(id);
  }
}