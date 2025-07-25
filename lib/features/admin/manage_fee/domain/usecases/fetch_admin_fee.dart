import '/features/admin/manage_fee/domain/entities/monthly_fee.dart';
import '/features/admin/manage_fee/domain/repositories/fee_repo.dart';
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
