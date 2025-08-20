import '/features/admin/restaurants/domain/repositories/restaurant_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class ActiveRestaurantUsecase extends UseCase<DataState<String>, String> {
  final IRestaurantRepo repo;

  ActiveRestaurantUsecase(this.repo);

  @override
  Future<DataState<String>> call(parms) {
    return repo.activeRestaurant(parms);
  }
}
