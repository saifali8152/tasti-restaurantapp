import '/features/common/manage_fee/domain/entities/initialize_payment.dart';
import '/features/common/auth/data/models/user.dart';
import '../entities/monthly_fee.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class IMonthlyFeeRepo {
  Future<DataState<String>> updateMonthlyFee(UpdateMonthlyFeeParms parms);
  Future<DataState<MonthlyFeeEntity>> fetchMonthlyFee();
  Future<DataState<UserModel>> verifyPayment(String reference);
  Future<DataState<InitializePaymentEntity>> initializePayment(String amount);
}
