import 'package:equatable/equatable.dart';
import '/features/common/location/data/models/location_model.dart';
import '/features/common/location/data/models/prediction_model.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

class LocationChanged extends LocationEvent {
  final String location;

  const LocationChanged({required this.location});
}

class SetLocationValues extends LocationEvent {
  final LocationModel location;
  final String description;

  const SetLocationValues({
    required this.location,
    required this.description,
  });
}

class SelectLocation extends LocationEvent {
  final bool locationSet;
  final PredictionModel? selectedLocation;

  const SelectLocation(
      {required this.locationSet, required this.selectedLocation});
}
