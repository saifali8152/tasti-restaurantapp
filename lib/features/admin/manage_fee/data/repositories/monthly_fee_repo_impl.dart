import 'package:tasti_restaurant_app/features/admin/manage_fee/domain/entities/initialize_payment.dart';
import 'package:tasti_restaurant_app/features/auth/data/models/user.dart';
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
  
  @override
  Future<DataState<UserModel>> verifyPayment(String reference) async {
    try {
      final result = await dataSource.verifyPayment(reference);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<InitializePaymentEntity>> initializePayment(String amount) async{
    try {
      final result = await dataSource.initializePayment(amount);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
