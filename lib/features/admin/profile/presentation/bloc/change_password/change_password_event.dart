import '/core/parms/parms.dart';

abstract class ChangePasswordEvent {}

class ChangePasswordRequested extends ChangePasswordEvent {
  final ChangePasswordParms parms;

  ChangePasswordRequested(this.parms);
}
