import 'package:tasti_restaurant_app/core/models/pagination.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/features/admin/today_queries/domain/entities/today_queries.dart';

class TodayQueriesState  {
  final ApiResponse<List<TodayQueriesItem>> fetchResponse;
  final ApiResponse<String> deleteResponse;
  final ApiResponse<String> replyResponse;
  final PaginationModel? pagination;
  final bool isLoadingMore;
  final String query;

  TodayQueriesState({
    required this.fetchResponse,
    required this.deleteResponse,
    required this.replyResponse,
    this.pagination,
    this.isLoadingMore = false,
    this.query = '',
  });

  TodayQueriesState copyWith({
    ApiResponse<List<TodayQueriesItem>>? fetchResponse,
    ApiResponse<String>? deleteResponse,
    ApiResponse<String>? replyResponse,
    PaginationModel? pagination,
    bool? isLoadingMore,
    String? query,
  }) {
    return TodayQueriesState(
      fetchResponse: fetchResponse ?? this.fetchResponse,
      replyResponse: replyResponse ?? this.replyResponse,
      deleteResponse: deleteResponse ?? this.deleteResponse,
      pagination: pagination ?? this.pagination,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      query: query ?? this.query,
    );
  }
}