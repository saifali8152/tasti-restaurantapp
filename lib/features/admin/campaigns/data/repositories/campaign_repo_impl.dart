import 'package:tasti_restaurant_app/features/admin/campaigns/data/models/campaigns.dart';
import 'package:tasti_restaurant_app/features/admin/campaigns/data/models/campaigns_by_res.dart';
import 'package:tasti_restaurant_app/features/admin/campaigns/domain/repositories/campaigns_repo.dart';
import '../data_sources/queries_remote_source.dart';
import '/core/network/response.dart';

class CampaignRepoImpl extends ICampaignsRepo {
  final ICampaignRemoteSourceApi dataSource;
  CampaignRepoImpl(this.dataSource);
  
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
