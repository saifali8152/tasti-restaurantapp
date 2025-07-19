import 'package:tasti_restaurant_app/features/admin/manage_fee/domain/entities/monthly_fee.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class IMonthlyFeeRepo {
  Future<DataState<String>> addSMSBundle(AddSMSBundleParms parms);
  Future<DataState<String>> manageSmsBundleDiscount(ManageSmsBundleDiscountParms parms);
  Future<DataState<MonthlyFeeEntity>> fetchMonthlyFee();
}
