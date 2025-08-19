import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/data/models/init_payment.dart';
import 'package:tasti_restaurant_app/features/targeted_campaign/data/models/targeted_campaign.dart';
import 'package:tasti_restaurant_app/features/targeted_campaign/domain/repositories/targeted_campaign.dart';
import '/core/parms/parms.dart';
import '../data_sources/bundle_billing_remote_repo.dart';
import '/core/network/response.dart';

class TargetedCampaignRepoImpl extends ITargetedCampaignRepo {
  final ITargetedCampaignRemoteApi remote;
  TargetedCampaignRepoImpl(this.remote);

  @override
  Future<DataState<InitPaymentModel>> initCampaignPayment(String bundleId) async {
    try {
      final result = await remote.initCampaignPayment(bundleId);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
  @override
  Future<DataState<String>> verifyCampaignPayment(VerifyCampaignPaymentParms parms) async {
    try {
      final result = await remote.verifyCampaignPayment(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<TargetedCampaignModel>> addTargetedCampaign(AddTargetedCampaignParms parms)async {
    try {
      final result = await remote.addTargetedCampaign(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
