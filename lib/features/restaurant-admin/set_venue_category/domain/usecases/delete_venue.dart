import '/features/restaurant-admin/set_venue_category/domain/repositories/venue_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class DeleteVenueUsecase extends UseCase<DataState<String>, String>{
  final IVenueRepo repo;
  
  DeleteVenueUsecase(this.repo);

  @override
  Future<DataState<String>> call(parm) {
    return repo.deleteVenue(parm);
  }
}