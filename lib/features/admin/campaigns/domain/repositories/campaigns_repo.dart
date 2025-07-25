import '/features/admin/campaigns/domain/entities/campaigns.dart';
import '/features/admin/campaigns/domain/entities/campaigns_by_res.dart';
import '/core/network/response.dart';

abstract class ICampaignsRepo {
  Future<DataState<List<CampaignsEntity>>> fetchCampaigns();
  Future<DataState<List<CampaignsByResEntity>>> fetchCampaignsByRes(String id);
  Future<DataState<String>> approveCampaign(String id);
}
