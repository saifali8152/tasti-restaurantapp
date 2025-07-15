import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class ISMSBundleRemoteSourceApi {
  Future<String> addSMSBundle(AddSMSBundleParms parms);
}

class SMSBundleSourceRemoteApiImpl extends ISMSBundleRemoteSourceApi {
  final IApiService networkApiService;
  SMSBundleSourceRemoteApiImpl(this.networkApiService);

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
}
