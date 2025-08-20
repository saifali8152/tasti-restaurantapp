import '/core/parms/parms.dart';
import '/features/restaurant-admin/targeted_campaign/domain/entities/targeted_campaign.dart';
import '/features/restaurant-admin/targeted_campaign/domain/repositories/targeted_campaign.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class AddTargetedCampaignUsecase extends UseCase<DataState<TargetedCampaignEntity>, AddTargetedCampaignParms>{
  final ITargetedCampaignRepo repo;
  
  AddTargetedCampaignUsecase(this.repo);

  @override
  Future<DataState<TargetedCampaignEntity>> call(parms) {
    return repo.addTargetedCampaign(parms);
  }
}