import '/features/admin/manage_sms/domain/repositories/sms_bundle_repo.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/usecase/usecase.dart';

class AddSMSBundleUsecase extends UseCase<DataState<String>, AddSMSBundleParms>{
  final ISMSBundleRepo repo;
  
  AddSMSBundleUsecase(this.repo);

  @override
  Future<DataState<String>> call(AddSMSBundleParms parms) {
    return repo.addSMSBundle(parms);
  }
}