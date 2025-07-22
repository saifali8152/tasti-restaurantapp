import 'package:tasti_restaurant_app/features/admin/requests/domain/entities/requests.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class IRequestRepo {
  Future<DataState<RequestEntity>> fetchRequests(RequestParms parms);
  Future<DataState<String>> deleteRequest(String id);
}
