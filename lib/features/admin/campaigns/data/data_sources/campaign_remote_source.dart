import 'package:tasti_restaurant_app/features/admin/campaigns/data/models/campaigns.dart';
import 'package:tasti_restaurant_app/features/admin/campaigns/data/models/campaigns_by_res.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class ICampaignRemoteSourceApi {
  Future<List<CampaignsModel>> fetchCampaign();
  Future<List<CampaignsByResModel>> fetchCampaignByRes(String id);
}

class CampaignSourceRemoteApiImpl extends ICampaignRemoteSourceApi {
  final IApiService networkApiService;
  CampaignSourceRemoteApiImpl(this.networkApiService);

  @override
  Future<List<CampaignsModel>> fetchCampaign() async {
    String url = AppUrls.adminFetchCampaigns;

    final response = await networkApiService.get(url);
    final List<dynamic> rawList = response['data'];    
    final List<CampaignsModel> campaigns = rawList.map((campaign) => CampaignsModel.fromJson(campaign)).toList();
    return campaigns;
  }
  
  @override
  Future<List<CampaignsByResModel>> fetchCampaignByRes(String id) async {
    String url = AppUrls.adminFetchCampaignsByRes;

    final payload = {"res_id": id};

    final response = await networkApiService.get(url, queryParams: payload);
    final List<dynamic> rawList = response['data'];    
    final List<CampaignsByResModel> campaigns = rawList.map((campaign) => CampaignsByResModel.fromJson(campaign)).toList();
    return campaigns;
  }
}
