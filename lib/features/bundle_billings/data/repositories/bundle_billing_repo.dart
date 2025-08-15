import 'package:tasti_restaurant_app/features/bundle_billings/data/models/bundle.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/data/models/sms.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/data/models/transaction_history.dart';
import '/core/parms/parms.dart';
import '../data_sources/bundle_billing_remote_repo.dart';
import '../../domain/repositories/bundle_billing.dart';
import '/core/network/response.dart';

class BundleBillingRepoImpl extends IBundleBillingRepo {
  final IBundleBillingRemoteApi remote;
  BundleBillingRepoImpl(this.remote);

  @override
  Future<DataState<String>> addSeatingAreas(SeatingAreaParms parms) async {
    try {
      final result = await remote.addSeatingArea(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
  @override
  Future<DataState<String>> updateSeatingAreas(SeatingAreaParms parms) async {
    try {
      final result = await remote.updateSeatingArea(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<String>> deleteSeatingArea(String id) async {
    try {
      final result = await remote.deleteSeatingArea(id);
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
