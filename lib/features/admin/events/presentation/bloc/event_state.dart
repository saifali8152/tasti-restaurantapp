import '/core/models/pagination.dart';
import '/core/network/response.dart';
import '/features/admin/events/domain/entities/event.dart';

class EventState  {
  final ApiResponse<List<EventItem>> fetchResponse;
  final ApiResponse<String> deleteResponse;
  final ApiResponse<String> addResponse;
  final ApiResponse<String> updateResponse;
  final PaginationModel? pagination;
  final bool isLoadingMore;
  final String query;

  EventState({
    required this.fetchResponse,
    required this.deleteResponse,
    required this.addResponse,
    required this.updateResponse,
    this.pagination,
    this.isLoadingMore = false,
    this.query = '',
  });

  EventState copyWith({
    ApiResponse<List<EventItem>>? fetchResponse,
    ApiResponse<String>? deleteResponse,
    ApiResponse<String>? addResponse,
    ApiResponse<String>? updateResponse,
    PaginationModel? pagination,
    bool? isLoadingMore,
    String? query,
  }) {
    return EventState(
      fetchResponse: fetchResponse ?? this.fetchResponse,
      deleteResponse: deleteResponse ?? this.deleteResponse,
      addResponse: addResponse ?? this.addResponse,
      updateResponse: updateResponse ?? this.updateResponse,
      pagination: pagination ?? this.pagination,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      query: query ?? this.query,
    );
  }
}