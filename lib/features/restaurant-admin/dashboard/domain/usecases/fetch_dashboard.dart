import 'package:tasti_restaurant_app/features/restaurant-admin/dashboard/domain/repositories/dashboard_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';
import '../entities/dashboard.dart';

class FetchDashboardUseCase extends UseCase<DataState<DashboardEntity>, void>{
  final IDashboardRepo repo;
  
  FetchDashboardUseCase(this.repo);

  @override
  Future<DataState<DashboardEntity>> call(arms) {
    return repo.fetchDashboardUseCase();
  }
}