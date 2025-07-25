import '/core/models/pagination.dart';
import '/core/network/response.dart';
import '/features/admin/manage_sms/domain/entities/admin_sms.dart';

abstract class AdminSmsBundleState {}
class FetchAdminSmsLoaded extends AdminSmsBundleState {
  final ApiResponse<List<AdminSmsItem>> fetchResponse;
  final ApiResponse<String> deleteResponse;
  final ApiResponse<String> addResponse;
  final PaginationModel? pagination;
  final bool isLoadingMore;

  FetchAdminSmsLoaded({
    required this.fetchResponse,
    required this.deleteResponse,
    required this.addResponse,
    this.pagination,
    this.isLoadingMore = false,
  });

  FetchAdminSmsLoaded copyWith({
    ApiResponse<List<AdminSmsItem>>? fetchResponse,
    ApiResponse<String>? deleteResponse,
    ApiResponse<String>? addResponse,
    PaginationModel? pagination,
    bool? isLoadingMore,
  }) {
    return FetchAdminSmsLoaded(
      fetchResponse: fetchResponse ?? this.fetchResponse,
      deleteResponse: deleteResponse ?? this.deleteResponse,
      addResponse: addResponse ?? this.addResponse,
      pagination: pagination ?? this.pagination,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}