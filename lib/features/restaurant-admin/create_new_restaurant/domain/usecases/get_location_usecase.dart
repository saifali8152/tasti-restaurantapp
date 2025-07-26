import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/domain/entities/location_entity.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/domain/repositories/create_restaurant_repo.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';

class GetPlaceDetailsUseCase {
  final ICreateRestaurantRepo repository;
  GetPlaceDetailsUseCase(this.repository);

  Future<DataState<LocationEntity>> call(GetPlaceDetailsParms params) async {
    return repository.getPlaceDetails(params);
  }
}
