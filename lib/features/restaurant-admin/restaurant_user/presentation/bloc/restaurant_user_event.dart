import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';

abstract class RestaurantUserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddRestaurantUserEvent extends RestaurantUserEvent {
  final AddRestaurantUserParms parms;
  AddRestaurantUserEvent(this.parms);
}

class FetchRestaurantUserEvent extends RestaurantUserEvent {
  final String id;
  FetchRestaurantUserEvent(this.id);
}

class UpdateRestaurantUserEvent extends RestaurantUserEvent {
  final AddRestaurantUserParms parms;
  UpdateRestaurantUserEvent(this.parms);
}
