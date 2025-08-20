import 'package:equatable/equatable.dart';
import '/core/parms/parms.dart';

abstract class WorkingHoursEvent extends Equatable {
  const WorkingHoursEvent();

  @override
  List<Object?> get props => [];
}
class FetchWorkingHoursEvent extends WorkingHoursEvent {
  final String id;

  const FetchWorkingHoursEvent(this.id);
}

class UpdateWorkingHoursEvent extends WorkingHoursEvent {
  final UpdateWorkingHourParms parms;

  const UpdateWorkingHoursEvent(this.parms);
}

class AddWorkingHoursEvent extends WorkingHoursEvent {
  final AddWorkingHourParms parms;

  const AddWorkingHoursEvent(this.parms);
}
