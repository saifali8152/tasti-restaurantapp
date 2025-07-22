import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/enum/request_type.dart';

abstract class RequestEvents extends Equatable {
  const RequestEvents();

  @override
  List<Object?> get props => [];
}

class AdminDeleteRequest extends RequestEvents {
  final int id;

  const AdminDeleteRequest(this.id);
}

class SearchRequests extends RequestEvents {
  final String query;
  final RequestType type;

  const SearchRequests(this.query, this.type);
}

class FetchInitialRequests extends RequestEvents {
  final RequestType type;

  const FetchInitialRequests({required this.type });

  @override
  List<Object?> get props => [type];
}

class FetchMoreRequests extends RequestEvents {
  final RequestType type;

  const FetchMoreRequests({required this.type });

  @override
  List<Object?> get props => [type];
}
