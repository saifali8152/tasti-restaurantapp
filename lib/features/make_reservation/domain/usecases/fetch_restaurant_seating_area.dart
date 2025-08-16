import 'package:tasti_restaurant_app/features/make_reservation/domain/entities/restaurant_seating_area.dart';
import 'package:tasti_restaurant_app/features/make_reservation/domain/repositories/make_reservations.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchRestaurantSeatingAreaUsecase extends UseCase<DataState<List<RestaurantSeatingAreaEntity>>, String>{
  final IMakeReservationRepo repo;
  
  FetchRestaurantSeatingAreaUsecase(this.repo);

  @override
  Future<DataState<List<RestaurantSeatingAreaEntity>>> call(parm) {
    return repo.fetchSeatingArea(parm);
  }
}