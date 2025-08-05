import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/domain/entities/venue.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class IVenueRepo {
  Future<DataState<VenueEntity>> fetchVenues(String id);
  Future<DataState<String>> deleteVenue(String id);
  Future<DataState<String>> addVenue(AddVenueParms parms);
}
