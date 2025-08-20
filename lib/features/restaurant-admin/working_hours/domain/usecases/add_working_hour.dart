import '/core/parms/parms.dart';
import '/features/restaurant-admin/working_hours/domain/repositories/working_hour.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class AddWorkingHourUsecase extends UseCase<DataState<String>, AddWorkingHourParms>{
  final IWorkingHourRepo repo;
  
  AddWorkingHourUsecase(this.repo);

  @override
  Future<DataState<String>> call(parm) {
    return repo.addWorkingHours(parm);
  }
}