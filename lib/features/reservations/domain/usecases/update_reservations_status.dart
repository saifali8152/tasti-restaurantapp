import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/reservations/domain/entities/reservation.dart';
import 'package:tasti_restaurant_app/features/reservations/domain/repositories/reservation.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class UpdateReservationsStatusUsecase extends UseCase<DataState<ReservationItem>, UpdateReservationStatusParms>{
  final IReservationRepo repo;
  
  UpdateReservationsStatusUsecase(this.repo);

  @override
  Future<DataState<ReservationItem>> call(parms) {
    return repo.updateReservationStatus(parms);
  }
}