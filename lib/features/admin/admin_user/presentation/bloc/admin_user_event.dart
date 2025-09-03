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

class FetchAdminUserEvent extends AdminUserEvent {
  final String id;
  FetchAdminUserEvent(this.id);
}

class DeleteAdminUserEvent extends AdminUserEvent {
  final DeleteAdminUserParms parms;
  DeleteAdminUserEvent(this.parms);
}

class UpdateAdminUserEvent extends AdminUserEvent {
  final AddAdminUserParms parms;
  UpdateAdminUserEvent(this.parms);
}
