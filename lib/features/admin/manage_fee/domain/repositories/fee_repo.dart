import 'package:tasti_restaurant_app/features/admin/manage_fee/domain/entities/initialize_payment.dart';
import 'package:tasti_restaurant_app/features/auth/data/models/user.dart';
import '/features/admin/manage_fee/domain/entities/monthly_fee.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class IMonthlyFeeRepo {
  Future<DataState<String>> updateMonthlyFee(UpdateMonthlyFeeParms parms);
  Future<DataState<MonthlyFeeEntity>> fetchMonthlyFee();
  Future<DataState<UserModel>> verifyPayment(String reference);
  Future<DataState<InitializePaymentEntity>> initializePayment(String amount);
}
