import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/data/models/prediction_model.dart';

abstract class CreateNewRestaurantEvent extends Equatable {
  const CreateNewRestaurantEvent();

  @override
  List<Object?> get props => [];
}

class LocationChanged extends CreateNewRestaurantEvent {
  final String location;

  const LocationChanged({required this.location});
}

class SelectLocation extends CreateNewRestaurantEvent {
  final bool locationSet;
  final PredictionModel? selectedLocation;

  const SelectLocation(
      {required this.locationSet, required this.selectedLocation});
}

class PhoneNumberChanged extends CreateNewRestaurantEvent {
  final String phoneNumber;

  const PhoneNumberChanged(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class CreateNewRestaurantSubmitted extends CreateNewRestaurantEvent {
  final CreateRestaurantParms parms;

  const CreateNewRestaurantSubmitted(this.parms);
}
