import 'package:tasti_restaurant_app/core/models/pagination.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/features/admin/events/domain/entities/event.dart';

class EventState  {
  final ApiResponse<List<EventItem>> fetchResponse;
  final ApiResponse<String> deleteResponse;
  final PaginationModel? pagination;
  final bool isLoadingMore;
  final String query;

  EventState({
    required this.fetchResponse,
    required this.deleteResponse,
    this.pagination,
    this.isLoadingMore = false,
    this.query = '',
  });

  EventState copyWith({
    ApiResponse<List<EventItem>>? fetchResponse,
    ApiResponse<String>? deleteResponse,
    PaginationModel? pagination,
    bool? isLoadingMore,
    String? query,
  }) {
    return EventState(
      fetchResponse: fetchResponse ?? this.fetchResponse,
      deleteResponse: deleteResponse ?? this.deleteResponse,
      pagination: pagination ?? this.pagination,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      query: query ?? this.query,
    );
  }
}