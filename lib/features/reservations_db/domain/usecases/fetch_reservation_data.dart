import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/resevation_data.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/repositories/reservations_db.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchReservationDataUsecase extends UseCase<DataState<List<ReservationDataEntity>>, String>{
  final IReservationDbRepo repo;
  
  FetchReservationDataUsecase(this.repo);

  @override
  Future<DataState<List<ReservationDataEntity>>> call(id) {
    return repo.fetchReservations(id);
  }
}