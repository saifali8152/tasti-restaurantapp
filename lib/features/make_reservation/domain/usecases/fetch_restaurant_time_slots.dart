import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/make_reservation/domain/entities/restaurant_time_slots.dart';
import 'package:tasti_restaurant_app/features/make_reservation/domain/repositories/make_reservations.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchRestaurantTimeSlotsUsecase extends UseCase<DataState<RestaurantTimeSlotEntity>, FetchTimeSlotParms>{
  final IMakeReservationRepo repo;
  
  FetchRestaurantTimeSlotsUsecase(this.repo);

  @override
  Future<DataState<RestaurantTimeSlotEntity>> call(parms) {
    return repo.fetchTimeSlots(parms);
  }
}