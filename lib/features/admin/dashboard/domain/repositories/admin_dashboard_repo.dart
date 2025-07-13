import '../entities/admin_dashboard.dart';
import '/core/network/response.dart';

abstract class IAdminDashboardRepo {
  Future<DataState<AdminDashboardEntity>> fetchAdminDashboardUseCase();
}
