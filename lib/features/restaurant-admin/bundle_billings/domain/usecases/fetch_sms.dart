import '/features/restaurant-admin/bundle_billings/domain/entities/sms.dart';
import '/features/restaurant-admin/bundle_billings/domain/repositories/bundle_billing.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchSmsUsecase extends UseCase<DataState<List<SMSEntity>>, void>{
  final IBundleBillingRepo repo;
  
  FetchSmsUsecase(this.repo);

  @override
  Future<DataState<List<SMSEntity>>> call(parm) {
    return repo.fetchSMS();
  }
}