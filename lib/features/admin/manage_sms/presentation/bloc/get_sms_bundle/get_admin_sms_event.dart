import 'package:equatable/equatable.dart';
import '/core/parms/parms.dart';

abstract class FetchAdminSmsEvent extends Equatable {
  const FetchAdminSmsEvent();

  @override
  List<Object?> get props => [];
}

class AdminDeleteSmsRequested extends FetchAdminSmsEvent {
  final int id;

  const AdminDeleteSmsRequested(this.id); 
}

class AdminAddSmsRequested extends FetchAdminSmsEvent {
  final AddSMSBundleParms parms;
  const AdminAddSmsRequested(this.parms);
}

class FetchInitialAdminSms extends FetchAdminSmsEvent {}

class FetchMoreAdminSms extends FetchAdminSmsEvent {}
