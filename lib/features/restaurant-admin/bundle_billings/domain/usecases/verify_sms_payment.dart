import '/core/parms/parms.dart';
import '/features/restaurant-admin/bundle_billings/domain/repositories/bundle_billing.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class VerifySmsPaymentUsecase extends UseCase<DataState<String>, VerifySmsPaymentParms>{
  final IBundleBillingRepo repo;
  
  VerifySmsPaymentUsecase(this.repo);

  @override
  Future<DataState<String>> call(parms) {
    return repo.verifySmsPayment(parms);
  }
}