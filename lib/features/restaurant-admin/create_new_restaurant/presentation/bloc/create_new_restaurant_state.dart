import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/features/auth/domain/entities/user.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/data/models/location_model.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/data/models/prediction_model.dart';
import '/core/network/response.dart';

class CreateNewRestaurantState extends Equatable {
  final String phoneNumber;
  final ApiResponse<UserRestaurantEntity> createRestaurantResponse;
  final bool? locationSet;
  final LocationModel? location;
  final PredictionModel? selectedLocation;
  final ApiResponse<List<PredictionModel>> locationResponse;
  final String? locationAddress;

  const CreateNewRestaurantState({
    this.phoneNumber = '',
    this.location,
    this.selectedLocation,
    this.locationSet = false,
    required this.locationResponse,
    this.locationAddress = '',
    required this.createRestaurantResponse,
  });

  CreateNewRestaurantState copyWith({
    String? phoneNumber,
    ApiResponse<UserRestaurantEntity>? createRestaurantResponse,
    ApiResponse<List<PredictionModel>>? locationResponse,
    PredictionModel? selectedLocation,
    String? locationAddress,
    LocationModel? location,
    bool? locationSet,
  }) {
    return CreateNewRestaurantState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createRestaurantResponse: createRestaurantResponse ?? ApiResponse.initial(),
      locationAddress: locationAddress ?? this.locationAddress,
      locationResponse: locationResponse ?? this.locationResponse,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      location: location ?? this.location,
      locationSet: locationSet ?? this.locationSet,
    );
  }

  @override
  List<Object?> get props => [
        createRestaurantResponse,
        phoneNumber,
        locationAddress,
        locationResponse,
        selectedLocation,
        location,
        locationSet,
      ];
}
