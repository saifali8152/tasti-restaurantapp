import '/features/restaurant-admin/seating_area/domain/entities/seating_area.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class ISeatingAreaRepo {
  Future<DataState<String>> deleteSeatingArea(String id);
  Future<DataState<String>> addSeatingAreas(SeatingAreaParms parms);
  Future<DataState<String>> updateSeatingAreas(SeatingAreaParms parms);
  Future<DataState<List<SeatingAreaEntity>>> fetchSeatingAreas(String id);
}
