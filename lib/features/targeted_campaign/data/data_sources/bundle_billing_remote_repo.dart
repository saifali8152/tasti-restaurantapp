import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/data/models/init_payment.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class ITargetedCampaignRemoteApi {
  Future<String> addTargetedCampaign(AddTargetedCampaignParms parms);
  Future<InitPaymentModel> initCampaignPayment(String tempId);
  Future<String> verifyCampaignPayment(VerifyCampaignPaymentParms parms);
}

class TargetedCampaignRemoteApiImpl extends ITargetedCampaignRemoteApi {
  final IApiService networkApiService;
  TargetedCampaignRemoteApiImpl(this.networkApiService);

  @override
  Future<String> addTargetedCampaign(AddTargetedCampaignParms parms) async {
    var response = await networkApiService.post(AppUrls.addTargetCampaign, parms.toJson());
    return response['message'];
  }

  @override
  Future<InitPaymentModel> initCampaignPayment(String tempId) async {
    var response = await networkApiService.post(AppUrls.initCampaignPayment, {"temp_id": tempId});

    final InitPaymentModel initPayment = InitPaymentModel.fromJson(response['data']);
    return initPayment;
  }

  @override
  Future<String> verifyCampaignPayment(VerifyCampaignPaymentParms parms) async {
    var response = await networkApiService.post(AppUrls.verifyCampaignPayment, {
      "restaurant_id": parms.restaurantId,
      "reference": parms.reference,
      "temp_id": parms.tempId,
    });

    return response['message'];
  }
}
