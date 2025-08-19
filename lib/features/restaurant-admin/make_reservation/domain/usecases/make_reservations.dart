import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/make_reservation/domain/repositories/make_reservations.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class MakeReservationsUsecase extends UseCase<DataState<String>, MakeReservationParms>{
  final IMakeReservationRepo repo;
  
  MakeReservationsUsecase(this.repo);

  @override
  Future<DataState<String>> call(parm) {
    return repo.makeReservation(parm);
  }
}