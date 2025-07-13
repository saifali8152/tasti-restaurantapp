import 'package:tasti_restaurant_app/features/admin/dashboard/domain/entities/admin_dashboard.dart';

abstract class AdminDashboardState {}

class AdminDashboardInitial extends AdminDashboardState {}

class AdminDashboardLoading extends AdminDashboardState {}

class AdminDashboardSuccess extends AdminDashboardState {
  final AdminDashboardEntity data;

  AdminDashboardSuccess(this.data);
}

class AdminDashboardError extends AdminDashboardState {
  final String message;

  AdminDashboardError(this.message);
}
