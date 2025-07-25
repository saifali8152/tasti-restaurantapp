import '/features/admin/manage_fee/data/models/monthly_fee.dart';
import '/features/admin/manage_fee/domain/repositories/fee_repo.dart';
import '/core/parms/parms.dart';
import '../data_sources/monthly_fee_remote_source.dart';
import '/core/network/response.dart';

class MonthlyFeeRepoImpl extends IMonthlyFeeRepo {
  final IMonthlyFeeRemoteSourceApi dataSource;
  MonthlyFeeRepoImpl(this.dataSource);

  @override
  Future<DataState<String>> updateMonthlyFee(UpdateMonthlyFeeParms parms) async {
    try {
      final result = await dataSource.updateMonthlyFee(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<MonthlyFeeModel>> fetchMonthlyFee() async {
    try {
      final result = await dataSource.fetchMonthlyFee();
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
