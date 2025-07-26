import '../entities/dashboard.dart';
import '/core/network/response.dart';

abstract class IDashboardRepo {
  Future<DataState<DashboardEntity>> fetchDashboardUseCase();
}
