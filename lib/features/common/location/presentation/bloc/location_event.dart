import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/features/common/location/data/models/prediction_model.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

class LocationChanged extends LocationEvent {
  final String location;

  const LocationChanged({required this.location});
}

class SelectLocation extends LocationEvent {
  final bool locationSet;
  final PredictionModel? selectedLocation;

  const SelectLocation(
      {required this.locationSet, required this.selectedLocation});
}