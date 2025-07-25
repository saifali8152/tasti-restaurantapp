import '/features/admin/campaigns/data/models/campaigns.dart';
import '/features/admin/campaigns/data/models/campaigns_by_res.dart';
import '/features/admin/campaigns/domain/repositories/campaigns_repo.dart';
import '../data_sources/campaign_remote_source.dart';
import '/core/network/response.dart';

class CampaignRepoImpl extends ICampaignsRepo {
  final ICampaignRemoteSourceApi dataSource;
  CampaignRepoImpl(this.dataSource);
  
  @override
  Future<DataState<String>> approveCampaign(String id) async{
    try {
      final result = await dataSource.approveCampaign(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  @override
  Future<DataState<List<CampaignsModel>>> fetchCampaigns() async{
    try {
      final result = await dataSource.fetchCampaign();
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
  @override
  Future<DataState<List<CampaignsByResModel>>> fetchCampaignsByRes(String id) async{
    try {
      final result = await dataSource.fetchCampaignByRes(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
