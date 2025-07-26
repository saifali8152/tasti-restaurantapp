import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/env.dart';
import 'package:tasti_restaurant_app/features/auth/domain/entities/user.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/data/models/location_model.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/data/models/prediction_model.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class ICreateRestaurantRemoteApi {
  Future<UserRestaurantEntity> createRestaurant(CreateRestaurantParms parms);
  Future<DataState<List<PredictionModel>>> fetchPredictions(
      GetPlacePredictionParms params);
  Future<DataState<LocationModel>> fetchPlaceDetails(
      GetPlaceDetailsParms params);
}

class CreateRestaurantRemoteApiImpl extends ICreateRestaurantRemoteApi {
  final IApiService networkApiService;
  CreateRestaurantRemoteApiImpl(this.networkApiService);

  @override
  Future<UserRestaurantEntity> createRestaurant(CreateRestaurantParms parms) async {
    Map<String, dynamic> data = {
      "name": parms.name,
      "email": parms.email,
      "phone_number": parms.phone,
      "website": parms.website,
      "address": parms.address,
      "city": parms.city,
      "lat": parms.lat,
      "lon": parms.lon,
      "dress_code": parms.dressCode,
      "minimum_spend": parms.minimumSpend,
      "description": parms.description,
      "cuisines": parms.cuisines,
    };
    Map<String, MultipartFile> files = {};
    if (parms.image.isNotEmpty && !(parms.image.contains("http"))) {
      files = {
        "image": await MultipartFile.fromFile(parms.image,
            filename: parms.image.split('/').last),
      };
    }

    var response = await networkApiService.postMultipart(
        AppUrls.createRestaurant, data, files);
    return response['message'];
  }

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

      log("this is the cityy: address: $addressComponents");
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
