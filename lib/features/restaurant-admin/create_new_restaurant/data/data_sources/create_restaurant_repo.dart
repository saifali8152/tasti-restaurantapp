import 'package:dio/dio.dart';
import '/features/common/auth/data/models/user.dart';
import '/features/common/auth/domain/entities/user.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class ICreateRestaurantRemoteApi {
  Future<UserRestaurantEntity> createRestaurant(CreateRestaurantParms parms);
  Future<UserRestaurantEntity> updateRestaurant(UpdateRestaurantParms parms);
}

class CreateRestaurantRemoteApiImpl extends ICreateRestaurantRemoteApi {
  final IApiService networkApiService;
  CreateRestaurantRemoteApiImpl(this.networkApiService);

  @override
  Future<UserRestaurantEntity> updateRestaurant(UpdateRestaurantParms parms) async {
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
      "cost": parms.cost,
    };
    Map<String, MultipartFile> files = {};
    if (parms.image.isNotEmpty && !(parms.image.contains("http"))) {
      files = {
        "image": await MultipartFile.fromFile(parms.image,
            filename: parms.image.split('/').last),
      };
    }

    var response = await networkApiService.postMultipart(AppUrls.updateRestaurant, data, files);
    final rawRestaurant = response['restaurant'];
    final restaurant = UserRestaurantModel.fromJson(rawRestaurant);
    return restaurant;
  }
  
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
}
