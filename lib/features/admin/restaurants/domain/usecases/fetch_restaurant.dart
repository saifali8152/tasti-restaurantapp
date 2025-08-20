import '/features/admin/restaurants/domain/entities/restaurant.dart';
import '/features/admin/restaurants/domain/repositories/restaurant_repo.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/usecase/usecase.dart';

class FetchRestaurantUsecase extends UseCase<DataState<RestaurantEntity>, AllRestaurantParms> {
  final IRestaurantRepo repo;

  FetchRestaurantUsecase(this.repo);

  @override
  Future<DataState<RestaurantEntity>> call(AllRestaurantParms parms) {
    return repo.fetchRestaurant(parms);
  }
}
