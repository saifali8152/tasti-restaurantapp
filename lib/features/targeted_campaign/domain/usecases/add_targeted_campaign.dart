import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/targeted_campaign/domain/repositories/targeted_campaign.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class AddTargetedCampaignUsecase extends UseCase<DataState<String>, AddTargetedCampaignParms>{
  final ITargetedCampaignRepo repo;
  
  AddTargetedCampaignUsecase(this.repo);

  @override
  Future<DataState<String>> call(parms) {
    return repo.addTargetedCampaign(parms);
  }
}