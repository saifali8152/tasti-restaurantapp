import '/features/admin/dashboard/data/models/admin_dashboard.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IAdminDashboardRemoteApi {
  Future<DashboardModel> fetchAdminDashboard();
}

class AdminDashboardRemoteApiImpl extends IAdminDashboardRemoteApi {
  final IApiService networkApiService;
  AdminDashboardRemoteApiImpl(this.networkApiService);

  @override
  Future<DashboardModel> fetchAdminDashboard() async {
    var response = await networkApiService.get(AppUrls.adminDashboard);

    final Map<String, dynamic> adminDashboard = response;

    final DashboardModel dashboard = DashboardModel.fromJson(adminDashboard);
    return dashboard;
  }
}
