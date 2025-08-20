import '/features/restaurant-admin/set_venue_category/domain/entities/venue.dart';
import '/features/restaurant-admin/set_venue_category/domain/repositories/venue_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchVenueUsecase extends UseCase<DataState<VenueEntity>, String>{
  final IVenueRepo repo;
  
  FetchVenueUsecase(this.repo);

  @override
  Future<DataState<VenueEntity>> call(parm) {
    return repo.fetchVenues(parm);
  }
}