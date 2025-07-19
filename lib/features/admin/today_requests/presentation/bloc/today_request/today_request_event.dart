import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';

abstract class TodayRequestEvents extends Equatable {
  const TodayRequestEvents();

  @override
  List<Object?> get props => [];
}

class AdminDeleteTodayRequest extends TodayRequestEvents {
  final int id;

  const AdminDeleteTodayRequest(this.id);
}

class AdminAddSmsRequested extends TodayRequestEvents {
  final AddSMSBundleParms parms;
  const AdminAddSmsRequested(this.parms);
}

class SearchTodayRequests extends TodayRequestEvents {
  final String query;

  const SearchTodayRequests(this.query);
}

class FetchInitialTodayRequests extends TodayRequestEvents {}

class FetchMoreTodayRequests extends TodayRequestEvents {}
