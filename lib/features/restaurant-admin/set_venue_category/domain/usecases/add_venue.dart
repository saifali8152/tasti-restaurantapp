import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/domain/repositories/venue_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class AddVenueUsecase extends UseCase<DataState<String>, AddVenueParms>{
  final IVenueRepo repo;
  
  AddVenueUsecase(this.repo);

  @override
  Future<DataState<String>> call(parm) {
    return repo.addVenue(parm);
  }
}