import 'package:tasti_restaurant_app/features/admin/manage_fee/domain/entities/initialize_payment.dart';
import '/features/admin/manage_fee/domain/repositories/fee_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class InitializePaymentFeeUsecase
    extends UseCase<DataState<InitializePaymentEntity>, String> {
  final IMonthlyFeeRepo repo;

  InitializePaymentFeeUsecase(this.repo);

  @override
  Future<DataState<InitializePaymentEntity>> call(parms) {
    return repo.initializePayment(parms);
  }
}
