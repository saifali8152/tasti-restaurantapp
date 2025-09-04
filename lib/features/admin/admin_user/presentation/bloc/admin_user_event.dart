import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';

abstract class AdminUserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddAdminUserEvent extends AdminUserEvent {
  final AddAdminUserParms parms;
  AddAdminUserEvent(this.parms);
}

class FetchAdminUserEvent extends AdminUserEvent {}

class DeleteAdminUserEvent extends AdminUserEvent {
  final int id;
  DeleteAdminUserEvent(this.id);
}

class UpdateAdminUserEvent extends AdminUserEvent {
  final AddAdminUserParms parms;
  UpdateAdminUserEvent(this.parms);
}
