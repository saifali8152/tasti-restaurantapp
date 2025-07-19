import 'package:tasti_restaurant_app/core/models/pagination.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/features/admin/today_requests/domain/entities/today_requests.dart';

class TodayRequestState  {
  final ApiResponse<List<TodayRequestItem>> fetchResponse;
  final ApiResponse<String> deleteResponse;
  final PaginationModel? pagination;
  final bool isLoadingMore;
  final String query;

  TodayRequestState({
    required this.fetchResponse,
    required this.deleteResponse,
    this.pagination,
    this.isLoadingMore = false,
    this.query = '',
  });

  TodayRequestState copyWith({
    ApiResponse<List<TodayRequestItem>>? fetchResponse,
    ApiResponse<String>? deleteResponse,
    PaginationModel? pagination,
    bool? isLoadingMore,
    String? query,
  }) {
    return TodayRequestState(
      fetchResponse: fetchResponse ?? this.fetchResponse,
      deleteResponse: deleteResponse ?? this.deleteResponse,
      pagination: pagination ?? this.pagination,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      query: query ?? this.query,
    );
  }
}