import 'package:tasti_restaurant_app/features/admin/dashboard/domain/repositories/admin_dashboard_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';
import '../entities/admin_dashboard.dart';

class FetchAdminDashboardUseCase extends UseCase<DataState<AdminDashboardEntity>, void>{
  final IAdminDashboardRepo repo;
  
  FetchAdminDashboardUseCase(this.repo);

  @override
  Future<DataState<AdminDashboardEntity>> call(arms) {
    return repo.fetchAdminDashboardUseCase();
  }
}