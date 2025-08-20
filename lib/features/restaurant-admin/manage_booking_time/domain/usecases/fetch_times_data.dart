import '/features/restaurant-admin/manage_booking_time/domain/entities/booking_time.dart';
import '/features/restaurant-admin/manage_booking_time/domain/repositories/booking_time.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchTimesDataUsecase extends UseCase<DataState<BookingTimeEntity>, String>{
  final IBookingTimeRepo repo;
  
  FetchTimesDataUsecase(this.repo);

  @override
  Future<DataState<BookingTimeEntity>> call(parm) {
    return repo.fetchTimes(parm);
  }
}