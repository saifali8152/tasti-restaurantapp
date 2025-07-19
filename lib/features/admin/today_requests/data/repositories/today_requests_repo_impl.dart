import 'package:tasti_restaurant_app/features/admin/today_requests/data/models/today_requests.dart';
import 'package:tasti_restaurant_app/features/admin/today_requests/domain/repositories/today_requests_repo.dart';
import '/core/parms/parms.dart';
import '../data_sources/today_requests_remote_source.dart';
import '/core/network/response.dart';

class TodayRequestRepoImpl extends ITodayRequestRepo {
  final ITodayRequestRemoteSourceApi dataSource;
  TodayRequestRepoImpl(this.dataSource);

  @override
  Future<DataState<String>> manageSmsBundleDiscount(ManageSmsBundleDiscountParms parms) async{
    try {
      final result = await dataSource.manageSmsBundleDiscount(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
 
  @override
  Future<DataState<String>> addSMSBundle(AddSMSBundleParms parms) async{
    try {
      final result = await dataSource.addSMSBundle(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
 
  @override
  Future<DataState<String>> deleteTodayRequest(String id) async{
    try {
      final result = await dataSource.deleteTodayRequest(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
  @override
  Future<DataState<TodayRequestModel>> fetchTodayRequests(PaginationParms parms) async{
    try {
      final result = await dataSource.fetchTodayRequest(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
