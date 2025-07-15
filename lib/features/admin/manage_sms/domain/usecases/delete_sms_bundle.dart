import '/features/admin/manage_sms/domain/repositories/sms_bundle_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class DeleteSMSBundleUsecase extends UseCase<DataState<String>, String>{
  final ISMSBundleRepo repo;
  
  DeleteSMSBundleUsecase(this.repo);

  @override
  Future<DataState<String>> call(parms) {
    return repo.deleteSMSBundle(parms);
  }
}