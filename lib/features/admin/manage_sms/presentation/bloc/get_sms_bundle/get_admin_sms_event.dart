import 'package:equatable/equatable.dart';

abstract class FetchAdminSmsEvent extends Equatable {
  const FetchAdminSmsEvent();

  @override
  List<Object?> get props => [];
}

class FetchInitialAdminSms extends FetchAdminSmsEvent {}

class FetchMoreAdminSms extends FetchAdminSmsEvent {}
