import '/features/restaurant-admin/dashboard/data/models/dashboard.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IDashboardRemoteApi {
  Future<DashboardModel> fetchDashboard();
}

class DashboardRemoteApiImpl extends IDashboardRemoteApi {
  final IApiService networkApiService;
  DashboardRemoteApiImpl(this.networkApiService);

  @override
  Future<DashboardModel> fetchDashboard() async {
    var response = await networkApiService.get(AppUrls.getDashboard);

    final Map<String, dynamic> dashboard = response;

    final DashboardModel parsedDashboard = DashboardModel.fromJson(dashboard);
    return parsedDashboard;
  }
}
