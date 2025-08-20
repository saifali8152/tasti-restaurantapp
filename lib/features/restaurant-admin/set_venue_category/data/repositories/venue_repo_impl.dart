import '/features/restaurant-admin/set_venue_category/data/models/venue.dart';
import '/core/parms/parms.dart';
import '../data_sources/venue_repo.dart';
import '../../domain/repositories/venue_repo.dart';
import '/core/network/response.dart';

class VenueRepoImpl extends IVenueRepo {
  final IVenueRemoteApi remote;
  VenueRepoImpl(this.remote);

  @override
  Future<DataState<String>> addVenue(AddVenueParms parms) async {
    try {
      final result = await remote.addVenue(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<String>> deleteVenue(String id) async {
    try {
      final result = await remote.deleteVenue(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<VenueModel>> fetchVenues(String id) async {
    try {
      final result = await remote.fetchVenues(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
