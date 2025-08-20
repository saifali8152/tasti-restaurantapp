import '/features/restaurant-admin/dashboard/domain/entities/dashboard.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardSuccess extends DashboardState {
  final DashboardEntity data;

  DashboardSuccess(this.data);
}

class DashboardError extends DashboardState {
  final String message;

  DashboardError(this.message);
}
