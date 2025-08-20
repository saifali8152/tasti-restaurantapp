import '/features/restaurant-admin/working_hours/data/models/working_hour.dart';
import '/core/parms/parms.dart';
import '../data_sources/working_hour_repo.dart';
import '../../domain/repositories/working_hour.dart';
import '/core/network/response.dart';

class WorkingHourRepoImpl extends IWorkingHourRepo {
  final IWorkingHourRemoteApi remote;
  WorkingHourRepoImpl(this.remote);

  @override
  Future<DataState<String>> addWorkingHours(AddWorkingHourParms parms) async {
    try {
      final result = await remote.addWorkingHours(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<String>> updateWorkingHours(UpdateWorkingHourParms parms) async {
    try {
      final result = await remote.updateWorkingHours(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<WorkingHourModel>> fetchWorkingHours(String id) async {
    try {
      final result = await remote.fetchWorkingHours(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
