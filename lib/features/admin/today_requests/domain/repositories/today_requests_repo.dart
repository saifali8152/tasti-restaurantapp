import 'package:tasti_restaurant_app/features/admin/today_requests/domain/entities/today_requests.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class ITodayRequestRepo {
  Future<DataState<TodayRequestEntity>> fetchTodayRequests(PaginationParms parms);
  Future<DataState<String>> deleteTodayRequest(String id);
}
