import 'package:tasti_restaurant_app/features/admin/dashboard/domain/entities/admin_dashboard.dart';
import '../data_sources/admin_dashboard_remote_api.dart';
import '../../domain/repositories/admin_dashboard_repo.dart';
import '/core/network/response.dart';

class AdminDashboardRepoImpl extends IAdminDashboardRepo {
  final IAdminDashboardRemoteApi remoteApi;
  AdminDashboardRepoImpl(this.remoteApi);

  @override
  Future<DataState<AdminDashboardEntity>> fetchAdminDashboardUseCase() async {
    try {
      final result = await remoteApi.fetchAdminDashboard();
      return DataSuccess(result.toEntity());
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
