import '/core/parms/parms.dart';
import '/features/restaurant-admin/manage_booking_time/domain/repositories/booking_time.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class ActivateTimeUsecase extends UseCase<DataState<String>, ActivateDeactivateTimeParms>{
  final IBookingTimeRepo repo;
  
  ActivateTimeUsecase(this.repo);

  @override
  Future<DataState<String>> call(parm) {
    return repo.activateTime(parm);
  }
}