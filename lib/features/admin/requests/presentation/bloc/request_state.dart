import '/core/models/pagination.dart';
import '/core/network/response.dart';
import '/features/admin/requests/domain/entities/requests.dart';

class RequestState  {
  final ApiResponse<List<RequestItem>> fetchResponse;
  final ApiResponse<String> deleteResponse;
  final PaginationModel? pagination;
  final bool isLoadingMore;
  final String query;

  RequestState({
    required this.fetchResponse,
    required this.deleteResponse,
    this.pagination,
    this.isLoadingMore = false,
    this.query = '',
  });

  RequestState copyWith({
    ApiResponse<List<RequestItem>>? fetchResponse,
    ApiResponse<String>? deleteResponse,
    PaginationModel? pagination,
    bool? isLoadingMore,
    String? query,
  }) {
    return RequestState(
      fetchResponse: fetchResponse ?? this.fetchResponse,
      deleteResponse: deleteResponse ?? this.deleteResponse,
      pagination: pagination ?? this.pagination,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      query: query ?? this.query,
    );
  }
}