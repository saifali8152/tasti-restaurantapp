import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/targeted_campaign/domain/repositories/targeted_campaign.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class VerifyCampaignPaymentUsecase extends UseCase<DataState<String>, VerifyCampaignPaymentParms>{
    final ITargetedCampaignRepo repo;
  
  VerifyCampaignPaymentUsecase(this.repo);

  @override
  Future<DataState<String>> call(parms) {
    return repo.verifyCampaignPayment(parms);
  }
}