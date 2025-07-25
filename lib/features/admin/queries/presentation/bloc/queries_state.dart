import '/core/models/pagination.dart';
import '/core/network/response.dart';
import '/features/admin/queries/domain/entities/queries.dart';

class QueriesState  {
  final ApiResponse<List<QueriesItem>> fetchResponse;
  final ApiResponse<String> deleteResponse;
  final ApiResponse<String> replyResponse;
  final PaginationModel? pagination;
  final bool isLoadingMore;
  final String query;

  QueriesState({
    required this.fetchResponse,
    required this.deleteResponse,
    required this.replyResponse,
    this.pagination,
    this.isLoadingMore = false,
    this.query = '',
  });

  QueriesState copyWith({
    ApiResponse<List<QueriesItem>>? fetchResponse,
    ApiResponse<String>? deleteResponse,
    ApiResponse<String>? replyResponse,
    PaginationModel? pagination,
    bool? isLoadingMore,
    String? query,
  }) {
    return QueriesState(
      fetchResponse: fetchResponse ?? this.fetchResponse,
      replyResponse: replyResponse ?? this.replyResponse,
      deleteResponse: deleteResponse ?? this.deleteResponse,
      pagination: pagination ?? this.pagination,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      query: query ?? this.query,
    );
  }
}