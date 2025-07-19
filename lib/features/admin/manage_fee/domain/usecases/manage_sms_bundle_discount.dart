import '/features/admin/manage_sms/domain/repositories/sms_bundle_repo.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/usecase/usecase.dart';

class ManageSmsBundleDiscountUsecase extends UseCase<DataState<String>, ManageSmsBundleDiscountParms>{
  final ISMSBundleRepo repo;
  
  ManageSmsBundleDiscountUsecase(this.repo);

  @override
  Future<DataState<String>> call(ManageSmsBundleDiscountParms parms) {
    return repo.manageSmsBundleDiscount(parms);
  }
}