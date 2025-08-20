import '/features/restaurant-admin/bundle_billings/data/models/bundle.dart';
import '/features/restaurant-admin/bundle_billings/data/models/init_payment.dart';
import '/features/restaurant-admin/bundle_billings/data/models/sms.dart';
import '/features/restaurant-admin/bundle_billings/data/models/transaction_history.dart';
import '/core/parms/parms.dart';
import '../data_sources/bundle_billing_remote_repo.dart';
import '../../domain/repositories/bundle_billing.dart';
import '/core/network/response.dart';

class BundleBillingRepoImpl extends IBundleBillingRepo {
  final IBundleBillingRemoteApi remote;
  BundleBillingRepoImpl(this.remote);

  @override
  Future<DataState<InitPaymentModel>> initSmsPayment(String bundleId) async {
    try {
      final result = await remote.initSmsPayment(bundleId);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
  @override
  Future<DataState<String>> verifySmsPayment(VerifySmsPaymentParms parms) async {
    try {
      final result = await remote.verifySmsPayment(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<List<SMSModel>>> fetchSMS() async {
    try {
      final result = await remote.fetchSMS();
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
  @override
  Future<DataState<BundleModel>> fetchBundles(PaginationParms parms) async {
    try {
      final result = await remote.fetchBundles(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
  @override
  Future<DataState<RestaurantTransactionHistoryModel>> fetchTransactionHistory(PaginationParms parms) async {
    try {
      final result = await remote.fetchTransactionHistory(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
