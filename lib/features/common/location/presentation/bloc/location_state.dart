import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/features/common/location/data/models/location_model.dart';
import 'package:tasti_restaurant_app/features/common/location/data/models/prediction_model.dart';
import '/core/network/response.dart';

class LocationState extends Equatable {
  final bool? locationSet;
  final LocationModel? location;
  final PredictionModel? selectedLocation;
  final ApiResponse<List<PredictionModel>> locationResponse;
  final String? locationAddress;

  const LocationState({
    this.location,
    this.selectedLocation,
    this.locationSet = false,
    required this.locationResponse,
    this.locationAddress = '',
  });

  LocationState copyWith({
    ApiResponse<List<PredictionModel>>? locationResponse,
    PredictionModel? selectedLocation,
    String? locationAddress,
    LocationModel? location,
    bool? locationSet,
  }) {
    return LocationState(
      locationAddress: locationAddress ?? this.locationAddress,
      locationResponse: locationResponse ?? this.locationResponse,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      location: location ?? this.location,
      locationSet: locationSet ?? this.locationSet,
    );
  }

  @override
  List<Object?> get props => [
        locationAddress,
        locationResponse,
        selectedLocation,
        location,
        locationSet,
      ];
}
