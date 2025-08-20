import '/core/network/response.dart';
import '/env.dart';
import '/features/common/location/data/models/location_model.dart';
import '/features/common/location/data/models/prediction_model.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class ILocationRemoteApi {
  Future<DataState<List<PredictionModel>>> fetchPredictions(
      GetPlacePredictionParms params);
  Future<DataState<LocationModel>> fetchPlaceDetails(
      GetPlaceDetailsParms params);
}

class LocationRemoteApiImpl extends ILocationRemoteApi {
  final IApiService networkApiService;
  LocationRemoteApiImpl(this.networkApiService);

  @override
  Future<DataState<List<PredictionModel>>> fetchPredictions(
      GetPlacePredictionParms params) async {
    final response = await networkApiService.get(
      '${AppUrls.googleApiUrl}?input=${params.query}&key=$googleApiKey&types=geocode&language=en',
    );

    if (response['status'] == "OK") {
      final List<PredictionModel> predictions =
          (response['predictions'] as List)
              .map((prediction) => PredictionModel.fromJson(prediction))
              .toList();

      return DataSuccess(predictions);
    } else {
      return DataFailure(response['status']);
    }
  }

  @override
  Future<DataState<LocationModel>> fetchPlaceDetails(
      GetPlaceDetailsParms params) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=${params.placeId}&key=$googleApiKey';
    final response = await networkApiService.get(url);

    if (response["status"] == "OK") {
      final locationJson = response['result']['geometry']['location'];
      final addressComponents =
          response['result']['address_components'] as List;

      String? city;
      for (final component in addressComponents) {
        final types = component['types'] as List;
        if (types.contains('locality')) {
          city = component['long_name'];
          break;
        }
      }

      final data = {
        'lat': locationJson['lat'],
        'lng': locationJson['lng'],
        'city': city,
      };

      final LocationModel location = LocationModel.fromJson(data);
      return DataSuccess(location);
    } else {
      return DataFailure(response['status']);
    }
  }
}
