import '/features/admin/manage_fee/domain/repositories/fee_repo.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/usecase/usecase.dart';

class UpdateAdminMonthlyFeeUsecdase
    extends UseCase<DataState<String>, UpdateMonthlyFeeParms> {
  final IMonthlyFeeRepo repo;

  UpdateAdminMonthlyFeeUsecdase(this.repo);

  @override
  Future<DataState<String>> call(parms) {
    return repo.updateMonthlyFee(parms);
  }
}
