import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations_db/domain/repositories/reservations_db.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchSmsAvailabilityUsecase extends UseCase<DataState<String>, FetchSmsAvailabilityParms>{
  final IReservationDbRepo repo;
  
  FetchSmsAvailabilityUsecase(this.repo);

  @override
  Future<DataState<String>> call(id) {
    return repo.fetchSmsAvailability(id);
  }
}