import 'package:tasti_restaurant_app/features/admin/manage_fee/data/models/monthly_fee.dart';
import 'package:tasti_restaurant_app/features/admin/manage_fee/domain/repositories/fee_repo.dart';
import '/core/parms/parms.dart';
import '../data_sources/monthly_fee_remote_source.dart';
import '/core/network/response.dart';

class MonthlyFeeRepoImpl extends IMonthlyFeeRepo {
  final IMonthlyFeeRemoteSourceApi dataSource;
  MonthlyFeeRepoImpl(this.dataSource);

  @override
  Future<DataState<String>> manageSmsBundleDiscount(
      ManageSmsBundleDiscountParms parms) async {
    try {
      final result = await dataSource.manageSmsBundleDiscount(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<String>> addSMSBundle(AddSMSBundleParms parms) async {
    try {
      final result = await dataSource.addSMSBundle(parms);
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
