import '/features/admin/manage_sms/data/models/admin_sms.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class ISMSBundleRemoteSourceApi {
  Future<String> addSMSBundle(AddSMSBundleParms parms);
  Future<String> manageSmsBundleDiscount(ManageSmsBundleDiscountParms parms);
  Future<String> deleteSMSBundle(String parms);
  Future<AdminSmsModel> fetchAdminSms(PaginationParms parms);
}

class SMSBundleSourceRemoteApiImpl extends ISMSBundleRemoteSourceApi {
  final IApiService networkApiService;
  SMSBundleSourceRemoteApiImpl(this.networkApiService);

  Map<String, dynamic> _normalizePaginatedPayload(dynamic response) {
    if (response is! Map<String, dynamic>) return {};

    final nested = response['data'];
    if (nested is Map<String, dynamic> &&
        nested.containsKey('data') &&
        nested.containsKey('pagination')) {
      return nested;
    }

    return response;
  }

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
  Future<String> deleteSMSBundle(String id) async {
    Map<String, dynamic> data = {};

    data = {
      "id": id,
    };
    var response =
        await networkApiService.post(AppUrls.adminDeleteSmsBundle, data);

    return response['message'];
  }

  @override
  Future<AdminSmsModel> fetchAdminSms(PaginationParms parms) async {
    Map<String, String> data = {};

    data = {
      "page": parms.page.toString(),
      "limit": parms.limit.toString(),
    };
    final response =
        await networkApiService.get(AppUrls.fetchAdminSMS, queryParams: data);

    final Map<String, dynamic> payload = _normalizePaginatedPayload(response);
    final AdminSmsModel adminSmsList = AdminSmsModel.fromJson(payload);

    return adminSmsList;
  }
}
