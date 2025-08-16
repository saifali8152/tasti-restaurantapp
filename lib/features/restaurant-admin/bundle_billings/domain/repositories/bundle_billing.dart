import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/domain/entities/bundle.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/domain/entities/init_payment.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/domain/entities/sms.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/domain/entities/transaction_history.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class IBundleBillingRepo {
  Future<DataState<List<SMSEntity>>> fetchSMS();
  Future<DataState<BundleEntity>> fetchBundles(PaginationParms parms);
  Future<DataState<ReataurantTransactionHistoryEntity>> fetchTransactionHistory(PaginationParms parms);
  Future<DataState<InitPaymentEntity>> initSmsPayment(String bundleId);
  Future<DataState<String>> verifySmsPayment(VerifySmsPaymentParms parms);
}
