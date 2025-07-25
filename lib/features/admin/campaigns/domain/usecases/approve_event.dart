import '/features/admin/campaigns/domain/repositories/campaigns_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class ApproveCampaignUsecase extends UseCase<DataState<String>, String> {
  final ICampaignsRepo repo;

  ApproveCampaignUsecase(this.repo);

  @override
  Future<DataState<String>> call(parms) {
    return repo.approveCampaign(parms);
  }
}
