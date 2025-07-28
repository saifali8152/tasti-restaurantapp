import 'package:tasti_restaurant_app/features/common/location/domain/entities/location_entity.dart';
import 'package:tasti_restaurant_app/features/common/location/domain/repositories/location_repo.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';

class GetPlaceDetailsUseCase {
  final ILocationRepo repository;
  GetPlaceDetailsUseCase(this.repository);

  Future<DataState<LocationEntity>> call(GetPlaceDetailsParms params) async {
    return repository.getPlaceDetails(params);
  }
}
