import 'package:tasti_restaurant_app/core/models/pagination.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/domain/entities/admin_sms.dart';

abstract class GetFetchAdminSmsState {}

class FetchAdminSmsInitial extends GetFetchAdminSmsState {}
class FetchAdminSmsLoading extends GetFetchAdminSmsState {}

class FetchAdminSmsLoaded extends GetFetchAdminSmsState {
  final List<AdminSmsItem> data;
  final PaginationModel pagination;
  final bool isLoadingMore;

  FetchAdminSmsLoaded({
    required this.data,
    required this.pagination,
    this.isLoadingMore = false,
  });

  FetchAdminSmsLoaded copyWith({
    List<AdminSmsItem>? data,
    PaginationModel? pagination,
    bool? isLoadingMore,
  }) {
    return FetchAdminSmsLoaded(
      data: data ?? this.data,
      pagination: pagination ?? this.pagination,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class FetchAdminSmsError extends GetFetchAdminSmsState {
  final String message;

  FetchAdminSmsError(this.message);
}
