import 'package:tasti_restaurant_app/features/bundle_billings/data/models/bundle.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/data/models/init_payment.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/data/models/sms.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/data/models/transaction_history.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IBundleBillingRemoteApi {
  Future<List<SMSModel>> fetchSMS();
  Future<BundleModel> fetchBundles(PaginationParms parms);
  Future<RestaurantTransactionHistoryModel> fetchTransactionHistory(
      PaginationParms parms);

  Future<InitPaymentModel> initSmsPayment(String bundleId);
  Future<String> verifySmsPayment(VerifySmsPaymentParms parms);
}

class BundleBillingRemoteApiImpl extends IBundleBillingRemoteApi {
  final IApiService networkApiService;
  BundleBillingRemoteApiImpl(this.networkApiService);

  @override
  Future<List<SMSModel>> fetchSMS() async {
    var response = await networkApiService.get(AppUrls.fetchSMS);
    final List<dynamic> rawList = response['data'];

    final List<SMSModel> sms =
        rawList.map((sms) => SMSModel.fromJson(sms)).toList();
    return sms;
  }

  @override
  Future<BundleModel> fetchBundles(PaginationParms parms) async {
    Map<String, String> data = {
      "id": parms.id,
      "limit": parms.limit,
      "page": parms.page,
    };

    var response = await networkApiService.get(
      AppUrls.fetchBundles,
      queryParams: data,
    );

    final BundleModel bundles = BundleModel.fromJson(response);
    return bundles;
  }

  @override
  Future<RestaurantTransactionHistoryModel> fetchTransactionHistory(
      PaginationParms parms) async {
    Map<String, String> data = {
      "limit": parms.limit,
      "page": parms.page,
    };

    var response = await networkApiService.get(
      AppUrls.fetchTransactionHistory,
      queryParams: data,
    );

    final RestaurantTransactionHistoryModel transactionHistory =
        RestaurantTransactionHistoryModel.fromJson(response);
    return transactionHistory;
  }

  @override
  Future<InitPaymentModel> initSmsPayment(String bundleId) async {
    var response = await networkApiService
        .post(AppUrls.initializeSmsPayment, {"bundle_id": bundleId});

    final InitPaymentModel initPayment = InitPaymentModel.fromJson(response['data']);
    return initPayment;
  }
  
  @override
  Future<String> verifySmsPayment(VerifySmsPaymentParms parms) async {
    var response = await networkApiService
        .post(AppUrls.verifySmsPayment, {"restaurant_id": parms.restaurantId, "reference": parms.reference});

    return response['date'];
  }
}
