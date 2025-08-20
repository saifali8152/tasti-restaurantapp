import '/features/restaurant-admin/working_hours/domain/entities/working_hour.dart';
import '/features/restaurant-admin/working_hours/domain/repositories/working_hour.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchWorkingHourUsecase extends UseCase<DataState<WorkingHourEntity>, String>{
  final IWorkingHourRepo repo;
  
  FetchWorkingHourUsecase(this.repo);

  @override
  Future<DataState<WorkingHourEntity>> call(String id) {
    return repo.fetchWorkingHours(id);
  }
}