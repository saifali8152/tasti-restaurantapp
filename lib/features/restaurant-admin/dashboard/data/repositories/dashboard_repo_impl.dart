import 'package:tasti_restaurant_app/features/restaurant-admin/dashboard/data/models/dashboard.dart';
import '../data_sources/dashboard_remote_api.dart';
import '../../domain/repositories/dashboard_repo.dart';
import '/core/network/response.dart';

class DashboardRepoImpl extends IDashboardRepo {
  final IDashboardRemoteApi remoteApi;
  DashboardRepoImpl(this.remoteApi);

  @override
  Future<DataState<DashboardModel>> fetchDashboardUseCase() async {
    try {
      final result = await remoteApi.fetchDashboard();
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
