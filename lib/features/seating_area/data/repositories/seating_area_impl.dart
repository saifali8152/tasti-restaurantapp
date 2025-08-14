import 'package:tasti_restaurant_app/features/seating_area/data/models/seating_area.dart';
import '/core/parms/parms.dart';
import '../data_sources/seating_area_remote_repo.dart';
import '../../domain/repositories/seating_area.dart';
import '/core/network/response.dart';

class SeatingAreaRepoImpl extends ISeatingAreaRepo {
  final ISeatingAreaRemoteApi remote;
  SeatingAreaRepoImpl(this.remote);

  @override
  Future<DataState<String>> addSeatingAreas(SeatingAreaParms parms) async {
    try {
      final result = await remote.addSeatingArea(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
  @override
  Future<DataState<String>> updateSeatingAreas(SeatingAreaParms parms) async {
    try {
      final result = await remote.updateSeatingArea(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<String>> deleteSeatingArea(String id) async {
    try {
      final result = await remote.deleteSeatingArea(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<List<SeatingAreaModel>>> fetchSeatingAreas(String id) async {
    try {
      final result = await remote.fetchSeatingArea(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
