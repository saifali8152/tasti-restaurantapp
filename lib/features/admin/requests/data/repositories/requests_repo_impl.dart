import 'package:tasti_restaurant_app/features/admin/requests/data/models/requests.dart';
import 'package:tasti_restaurant_app/features/admin/requests/domain/repositories/requests_repo.dart';
import '/core/parms/parms.dart';
import '../data_sources/requests_remote_source.dart';
import '/core/network/response.dart';

class RequestRepoImpl extends IRequestRepo {
  final IRequestRemoteSourceApi dataSource;
  RequestRepoImpl(this.dataSource);
  
  @override
  Future<DataState<String>> deleteRequest(String id) async{
    try {
      final result = await dataSource.deleteRequest(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
  @override
  Future<DataState<RequestModel>> fetchRequests(RequestParms parms) async{
    try {
      final result = await dataSource.fetchRequest(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
