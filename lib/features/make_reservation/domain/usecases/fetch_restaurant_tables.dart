import 'package:tasti_restaurant_app/features/make_reservation/domain/repositories/make_reservations.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchRestaurantTablesUsecase extends UseCase<DataState<List<String>>, String>{
  final IMakeReservationRepo repo;
  
  FetchRestaurantTablesUsecase(this.repo);

  @override
  Future<DataState<List<String>>> call(parm) {
    return repo.fetchTables(parm);
  }
}