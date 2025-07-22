import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/enum/request_type.dart';

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
  final RequestType type;

  const SearchTodayRequests(this.query, this.type);
}

class FetchInitialTodayRequests extends TodayRequestEvents {
  final RequestType type;

  const FetchInitialTodayRequests({this.type = RequestType.todayRequests});

  @override
  List<Object?> get props => [type];
}

class FetchMoreTodayRequests extends TodayRequestEvents {
  final RequestType type;

  const FetchMoreTodayRequests({this.type = RequestType.todayRequests});

  @override
  List<Object?> get props => [type];
}
