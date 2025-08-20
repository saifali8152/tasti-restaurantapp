import 'package:equatable/equatable.dart';
import '/core/parms/parms.dart';

abstract class CuisineEvent extends Equatable {
  const CuisineEvent();

  @override
  List<Object?> get props => [];
}
class FetchCuisineEvent extends CuisineEvent {
  final String id;

  const FetchCuisineEvent(this.id);
}

class DeleteCuisineEvent extends CuisineEvent {
  final String id;

  const DeleteCuisineEvent(this.id);
}

class AddCuisineEvent extends CuisineEvent {
  final AddCuisineParms parms;

  const AddCuisineEvent(this.parms);
}
