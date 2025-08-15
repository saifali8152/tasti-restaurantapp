import 'package:tasti_restaurant_app/features/bundle_billings/data/models/bundle.dart';
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

  Future<String> deleteSeatingArea(String id);
  Future<String> addSeatingArea(SeatingAreaParms parms);
  Future<String> updateSeatingArea(SeatingAreaParms parms);
}

class BundleBillingRemoteApiImpl extends IBundleBillingRemoteApi {
  final IApiService networkApiService;
  BundleBillingRemoteApiImpl(this.networkApiService);

  @override
  Future<List<SMSModel>> fetchSMS() async {
    var response = await networkApiService.get(AppUrls.fetchSMS);
    final List<dynamic> rawList = response['data'];

    final List<SMSModel> sms = rawList.map((sms) => SMSModel.fromJson(sms)).toList();
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

    final BundleModel bundles = BundleModel.fromJson(response['data']);
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
        RestaurantTransactionHistoryModel.fromJson(response['data']);
    return transactionHistory;
  }

  @override
  Future<String> addSeatingArea(SeatingAreaParms parms) async {
    var response =
        await networkApiService.post(AppUrls.addSeatingAreas, parms.toJson());
    return response['message'];
  }

  @override
  Future<String> updateSeatingArea(SeatingAreaParms parms) async {
    var response = await networkApiService.post(
        AppUrls.updateSeatingAreas, parms.toJson());
    return response['message'];
  }

  @override
  Future<String> deleteSeatingArea(String id) async {
    Map<String, String> data = {"id": id};

    var response =
        await networkApiService.post(AppUrls.deleteSeatingAreas, data);
    return response['message'];
  }
}
