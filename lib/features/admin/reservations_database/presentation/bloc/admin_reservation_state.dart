import '/features/admin/reservations_database/domain/entities/reservation.dart';

abstract class AdminReservationState {}

class AdminReservationInitial extends AdminReservationState {}
class AdminReservationLoading extends AdminReservationState {}

class AdminReservationLoaded extends AdminReservationState {
  final List<AdminReservationItem> data;
  final ReservationPagination pagination;
  final String search;
  final bool isLoadingMore;

  AdminReservationLoaded({
    required this.data,
    required this.pagination,
    this.isLoadingMore = false,
    this.search = '',
  });

  AdminReservationLoaded copyWith({
    List<AdminReservationItem>? data,
    ReservationPagination? pagination,
    bool? isLoadingMore,
    String? search,
  }) {
    return AdminReservationLoaded(
      data: data ?? this.data,
      pagination: pagination ?? this.pagination,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      search: search ?? this.search,
    );
  }
}

class AdminReservationError extends AdminReservationState {
  final String message;

  AdminReservationError(this.message);
}
