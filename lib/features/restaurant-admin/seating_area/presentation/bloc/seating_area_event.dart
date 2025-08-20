import 'package:equatable/equatable.dart';
import '/core/parms/parms.dart';

abstract class SeatingAreaEvent extends Equatable {
  const SeatingAreaEvent();

  @override
  List<Object?> get props => [];
}
class FetchSeatingAreaEvent extends SeatingAreaEvent {
  final String id;

  const FetchSeatingAreaEvent(this.id);
}

class DeleteSeatingAreaEvent extends SeatingAreaEvent {
  final int id;

  const DeleteSeatingAreaEvent(this.id);
}

class AddSeatingAreaEvent extends SeatingAreaEvent {
  final SeatingAreaParms parms;

  const AddSeatingAreaEvent(this.parms);
}

class UpdateSeatingAreaEvent extends SeatingAreaEvent {
  final SeatingAreaParms parms;

  const UpdateSeatingAreaEvent(this.parms);
}
