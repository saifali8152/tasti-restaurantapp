import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/domain/repositories/booking_time.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class UpdateTimeDurationUsecase extends UseCase<DataState<String>, UpdateDurationParms>{
  final IBookingTimeRepo repo;
  
  UpdateTimeDurationUsecase(this.repo);

  @override
  Future<DataState<String>> call(parm) {
    return repo.updateDuration(parm);
  }
}