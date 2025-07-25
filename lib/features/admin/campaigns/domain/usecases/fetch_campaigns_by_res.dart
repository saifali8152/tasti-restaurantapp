import '/features/admin/campaigns/domain/entities/campaigns_by_res.dart';
import '/features/admin/campaigns/domain/repositories/campaigns_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchCampaignsByResUsecase extends UseCase<DataState<List<CampaignsByResEntity>>, String> {
  final ICampaignsRepo repo;

  FetchCampaignsByResUsecase(this.repo);

  @override
  Future<DataState<List<CampaignsByResEntity>>> call(parms) {
    return repo.fetchCampaignsByRes(parms);
  }
}
