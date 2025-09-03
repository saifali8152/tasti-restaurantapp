import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/domain/entities/restaurant_user.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/domain/repositories/restaurant_user.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchRestaurantUserUsecase extends UseCase<DataState<List<RestaurantUserEntity>>, String>{
  final IRestaurantUserRepo repo;
  
  FetchRestaurantUserUsecase(this.repo);

  @override
  Future<DataState<List<RestaurantUserEntity>>> call(id) {
    return repo.fetchRestaurantUser(id);
  }
}