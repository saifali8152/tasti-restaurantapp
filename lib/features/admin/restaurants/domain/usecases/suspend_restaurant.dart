import 'package:tasti_restaurant_app/features/admin/restaurants/domain/repositories/restaurant_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class SuspendRestaurantUsecase extends UseCase<DataState<String>, String> {
  final IRestaurantRepo repo;

  SuspendRestaurantUsecase(this.repo);

  @override
  Future<DataState<String>> call(parms) {
    return repo.suspendRestaurant(parms);
  }
}
