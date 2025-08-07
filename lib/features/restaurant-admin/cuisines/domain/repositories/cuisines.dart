import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/domain/entities/cuisine.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class ICuisinesRepo {
  Future<DataState<String>> deleteCuisine(String id);
  Future<DataState<String>> addCuisine(AddCuisineParms parms);
  Future<DataState<List<CuisineEntity>>> fetchCuisine(String id);
}
