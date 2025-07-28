import '../entities/monthly_fee.dart';
import '../repositories/fee_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchAdminMonthlyFeeUsecase
    extends UseCase<DataState<MonthlyFeeEntity>, void> {
  final IMonthlyFeeRepo repo;

  FetchAdminMonthlyFeeUsecase(this.repo);

  @override
  Future<DataState<MonthlyFeeEntity>> call(parms) {
    return repo.fetchMonthlyFee();
  }
}
