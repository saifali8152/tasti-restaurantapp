import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddUserEvent extends UserEvent {
  final AddRestaurantUserParms parms;
  AddUserEvent(this.parms);
}

class UpdateUserEvent extends UserEvent {
  final AddRestaurantUserParms parms;
  UpdateUserEvent(this.parms);
}
