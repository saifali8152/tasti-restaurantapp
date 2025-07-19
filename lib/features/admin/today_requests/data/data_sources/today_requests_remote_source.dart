import 'package:tasti_restaurant_app/features/admin/today_requests/data/models/today_requests.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class ITodayRequestRemoteSourceApi {
  Future<TodayRequestModel> fetchTodayRequest(PaginationParms parms);
  Future<String> deleteTodayRequest(String parms);

  Future<String> addSMSBundle(AddSMSBundleParms parms);
  Future<String> manageSmsBundleDiscount(ManageSmsBundleDiscountParms parms);
}

class TodayRequestSourceRemoteApiImpl extends ITodayRequestRemoteSourceApi {
  final IApiService networkApiService;
  TodayRequestSourceRemoteApiImpl(this.networkApiService);

  @override
  Future<String> manageSmsBundleDiscount(ManageSmsBundleDiscountParms parms) async {
    Map<String, dynamic> data = {};

    data = {
      "id": parms.id,
      "discount": parms.discount,
      "percentage": parms.percentage
    };
    var response = await networkApiService.post(AppUrls.adminManageDiscount, data);

    return response['message'];
  }
  
  @override
  Future<String> addSMSBundle(AddSMSBundleParms parms) async {
    Map<String, dynamic> data = {};

    data = {
      "owner": parms.owner,
      "quantity": parms.quantity,
      "discount": parms.discount,
      "price": parms.price,
      "percentage": parms.percentage
    };
    var response = await networkApiService.post(AppUrls.adminAddSMS, data);

    return response['message'];
  }

  @override
  Future<String> deleteTodayRequest(String id) async {
    Map<String, dynamic> data = {};

    data = {
      "req_id": id,
    };
    var response =
        await networkApiService.post(AppUrls.adminDeleteTodayRequests, data);

    return response['message'];
  }

  @override
  Future<TodayRequestModel> fetchTodayRequest(PaginationParms parms) async {
    Map<String, String> data = {};

    data = {
      "page": parms.page.toString(),
      "limit": parms.limit.toString(),
      "search": parms.search.toString(),
    };
    final response =
        await networkApiService.get(AppUrls.adminFetchTodayRequests, queryParams: data);
    final Map<String, dynamic> adminReservation = response;
    final TodayRequestModel adminSmsList = TodayRequestModel.fromJson(adminReservation);
    return adminSmsList;
  }
}
