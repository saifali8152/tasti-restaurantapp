import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';

abstract class VenueEvent extends Equatable {
  const VenueEvent();

  @override
  List<Object?> get props => [];
}
class FetchVenueEvent extends VenueEvent {
  final String id;

  const FetchVenueEvent(this.id);
}

class SetCategory extends VenueEvent {
  final String category;

  const SetCategory(this.category);
}

class DeleteVenueEvent extends VenueEvent {
  final String id;

  const DeleteVenueEvent(this.id);
}

class AddVenueEvent extends VenueEvent {
  final AddVenueParms parms;

  const AddVenueEvent(this.parms);
}
