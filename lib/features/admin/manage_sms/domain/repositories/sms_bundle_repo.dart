import '/features/admin/manage_sms/domain/entities/admin_sms.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class ISMSBundleRepo {
  Future<DataState<String>> addSMSBundle(AddSMSBundleParms parms);
  Future<DataState<String>> manageSmsBundleDiscount(ManageSmsBundleDiscountParms parms);
  Future<DataState<String>> deleteSMSBundle(String id);
  Future<DataState<AdminSmsEntity>> fetchAdminSms(PaginationParms parms);
}
