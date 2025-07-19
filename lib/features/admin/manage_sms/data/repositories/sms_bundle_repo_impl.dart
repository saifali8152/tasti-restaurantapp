import 'package:tasti_restaurant_app/features/admin/manage_sms/data/models/admin_sms.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/domain/repositories/sms_bundle_repo.dart';
import '/core/parms/parms.dart';
import '../data_sources/sms_bundle_remote_source.dart';
import '/core/network/response.dart';

class SMSBundleRepoImpl extends ISMSBundleRepo {
  final ISMSBundleRemoteSourceApi dataSource;
  SMSBundleRepoImpl(this.dataSource);

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
  Future<DataState<String>> deleteSMSBundle(String id) async{
    try {
      final result = await dataSource.deleteSMSBundle(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
  @override
  Future<DataState<AdminSmsModel>> fetchAdminSms(PaginationParms parms) async{
    try {
      final result = await dataSource.fetchAdminSms(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
