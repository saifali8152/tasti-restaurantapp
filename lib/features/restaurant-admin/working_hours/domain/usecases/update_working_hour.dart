import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/domain/repositories/working_hour.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class UpdateWorkingHourUsecase extends UseCase<DataState<String>, UpdateWorkingHourParms>{
  final IWorkingHourRepo repo;
  
  UpdateWorkingHourUsecase(this.repo);

  @override
  Future<DataState<String>> call(UpdateWorkingHourParms parms) {
    return repo.updateWorkingHours(parms);
  }
}