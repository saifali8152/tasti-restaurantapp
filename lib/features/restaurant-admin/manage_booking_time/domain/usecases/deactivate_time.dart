import '/core/parms/parms.dart';
import '/features/restaurant-admin/manage_booking_time/domain/repositories/booking_time.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class DeactivateTimeUsecase extends UseCase<DataState<String>, ActivateDeactivateTimeParms>{
  final IBookingTimeRepo repo;
  
  DeactivateTimeUsecase(this.repo);

  @override
  Future<DataState<String>> call(parm) {
    return repo.deactivateTime(parm);
  }
}