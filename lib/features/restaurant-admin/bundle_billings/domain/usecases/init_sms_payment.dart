import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/domain/entities/init_payment.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/domain/repositories/bundle_billing.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class InitSmsPaymentUsecase extends UseCase<DataState<InitPaymentEntity>, String>{
  final IBundleBillingRepo repo;
  
  InitSmsPaymentUsecase(this.repo);

  @override
  Future<DataState<InitPaymentEntity>> call(bundleId) {
    return repo.initSmsPayment(bundleId);
  }
}