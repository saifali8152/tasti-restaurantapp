import '/features/common/auth/data/models/user.dart';
import '../repositories/fee_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class VerifyPaymentUsecase extends UseCase<DataState<UserModel>, String> {
  final IMonthlyFeeRepo repo;

  VerifyPaymentUsecase(this.repo);

  @override
  Future<DataState<UserModel>> call(reference) {
    return repo.verifyPayment(reference);
  }
}
