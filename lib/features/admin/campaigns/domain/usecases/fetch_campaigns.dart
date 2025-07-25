import '/features/admin/campaigns/domain/entities/campaigns.dart';
import '/features/admin/campaigns/domain/repositories/campaigns_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchCampaignsUsecase extends UseCase<DataState<List<CampaignsEntity>>, void> {
  final ICampaignsRepo repo;

  FetchCampaignsUsecase(this.repo);

  @override
  Future<DataState<List<CampaignsEntity>>> call(parms) {
    return repo.fetchCampaigns();
  }
}
