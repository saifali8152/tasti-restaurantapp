import 'package:equatable/equatable.dart';
import '/core/parms/parms.dart';

abstract class CreateNewRestaurantEvent extends Equatable {
  const CreateNewRestaurantEvent();

  @override
  List<Object?> get props => [];
}
class CreateNewRestaurantSubmitted extends CreateNewRestaurantEvent {
  final CreateRestaurantParms parms;

  const CreateNewRestaurantSubmitted(this.parms);
}

class UpdateNewRestaurantSubmitted extends CreateNewRestaurantEvent {
  final UpdateRestaurantParms parms;

  const UpdateNewRestaurantSubmitted(this.parms);
}
