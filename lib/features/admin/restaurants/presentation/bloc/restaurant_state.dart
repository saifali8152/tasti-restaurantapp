import 'package:tasti_restaurant_app/core/enum/restaurant_filter.dart';
import 'package:tasti_restaurant_app/features/admin/restaurants/domain/entities/restaurant.dart';
import '/core/models/pagination.dart';
import '/core/network/response.dart';

class RestaurantState  {
  final ApiResponse<List<RestaurantItem>> fetchResponse;
  final ApiResponse<String> activateResponse;
  final ApiResponse<String> suspendResponse;
  final RestaurantFilter filter;
  final PaginationModel? pagination;
  final bool isLoadingMore;
  final String query;

  RestaurantState({
    required this.fetchResponse,
    required this.activateResponse,
    required this.suspendResponse,
    required this.filter,
    this.pagination,
    this.isLoadingMore = false,
    this.query = '',
  });

  RestaurantState copyWith({
    ApiResponse<List<RestaurantItem>>? fetchResponse,
    ApiResponse<String>? activateResponse,
    ApiResponse<String>? suspendResponse,
    RestaurantFilter? filter,
    PaginationModel? pagination,
    bool? isLoadingMore,
    String? query,
  }) {
    return RestaurantState(
      fetchResponse: fetchResponse ?? this.fetchResponse,
      activateResponse: activateResponse ?? this.activateResponse,
      suspendResponse: suspendResponse ?? this.suspendResponse,
      filter: filter ?? this.filter,
      pagination: pagination ?? this.pagination,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      query: query ?? this.query,
    );
  }
}