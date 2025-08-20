import '/features/restaurant-admin/cuisines/data/models/cuisine.dart';
import '/core/parms/parms.dart';
import '../data_sources/cuisine_repo.dart';
import '../../domain/repositories/cuisines.dart';
import '/core/network/response.dart';

class CuisineRepoImpl extends ICuisinesRepo {
  final ICuisineRemoteApi remote;
  CuisineRepoImpl(this.remote);

  @override
  Future<DataState<String>> addCuisine(AddCuisineParms parms) async {
    try {
      final result = await remote.addCuisine(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<String>> deleteCuisine(String id) async {
    try {
      final result = await remote.deleteCuisine(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<List<CuisineModel>>> fetchCuisine(String id) async {
    try {
      final result = await remote.fetchCuisine(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
