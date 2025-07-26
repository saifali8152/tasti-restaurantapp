import '/features/admin/dashboard/data/models/admin_dashboard.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IAdminDashboardRemoteApi {
  Future<AdminDashboardModel> fetchAdminDashboard();
}

class AdminDashboardRemoteApiImpl extends IAdminDashboardRemoteApi {
  final IApiService networkApiService;
  AdminDashboardRemoteApiImpl(this.networkApiService);

  @override
  Future<AdminDashboardModel> fetchAdminDashboard() async {
    var response = await networkApiService.get(AppUrls.adminDashboard);

    final Map<String, dynamic> adminDashboard = response;

    final AdminDashboardModel dashboard = AdminDashboardModel.fromJson(adminDashboard);
    return dashboard;
  }
}
