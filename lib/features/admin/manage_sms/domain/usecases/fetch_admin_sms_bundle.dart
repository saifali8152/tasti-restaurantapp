import '/features/admin/manage_sms/domain/entities/admin_sms.dart';
import '/features/admin/manage_sms/domain/repositories/sms_bundle_repo.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/usecase/usecase.dart';

class FetchAdminSmsBundleUsecase
    extends UseCase<DataState<AdminSmsEntity>, PaginationParms> {
  final ISMSBundleRepo repo;

  FetchAdminSmsBundleUsecase(this.repo);

  @override
  Future<DataState<AdminSmsEntity>> call(PaginationParms parms) {
    return repo.fetchAdminSms(parms);
  }
}
