import 'package:equatable/equatable.dart';

abstract class TodayRequestEvents extends Equatable {
  const TodayRequestEvents();

  @override
  List<Object?> get props => [];
}

class AdminDeleteTodayRequest extends TodayRequestEvents {
  final int id;

  const AdminDeleteTodayRequest(this.id);
}

class SearchTodayRequests extends TodayRequestEvents {
  final String query;

  const SearchTodayRequests(this.query);
}

class FetchInitialTodayRequests extends TodayRequestEvents {}

class FetchMoreTodayRequests extends TodayRequestEvents {}
