import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/data/models/venue.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IVenueRemoteApi {
  Future<VenueModel> fetchVenues(String id);
  Future<String> deleteVenue(String id);
  Future<String> addVenue(AddVenueParms parms);
}

class VenueRemoteApiImpl extends IVenueRemoteApi {
  final IApiService networkApiService;
  VenueRemoteApiImpl(this.networkApiService);

  @override
  Future<String> addVenue(AddVenueParms parms) async {
    Map<String, String> data = {
      "id": parms.id.toString(),
      "names": parms.names,
    };

    var response = await networkApiService.post(AppUrls.addVenues, data);
    return response['message'];
  }

  @override
  Future<VenueModel> fetchVenues(String id) async {
    Map<String, String> data = {"id": id};

    var response = await networkApiService.get(
      AppUrls.getVenues,
      queryParams: data,
    );
    final VenueModel venue = VenueModel.fromJson(response['data'][0]);
    return venue;
  }

  @override
  Future<String> deleteVenue(String id) async {
    Map<String, String> data = {"id": id};

    var response = await networkApiService.post(AppUrls.deleteVenues, data);
    final venue = response['message'];
    return venue;
  }
}
