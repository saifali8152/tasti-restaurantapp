import 'package:tasti_restaurant_app/features/reservations_db/data/models/restaurant_campaign.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IReservationDbRemoteApi {
  Future<List<RestaurantCampaignModel>> fetchRestaurantCampaigns(String id);
}

class ReservationDbRemoteApiImpl extends IReservationDbRemoteApi {
  final IApiService networkApiService;
  ReservationDbRemoteApiImpl(this.networkApiService);

  @override
  Future<List<RestaurantCampaignModel>> fetchRestaurantCampaigns(String id) async {
    var response = await networkApiService.get(AppUrls.fetchCampaigns, queryParams: {"id": id});
    final List<dynamic> rawList = response['data'];

    final List<RestaurantCampaignModel> campaigns = rawList.map((campaign) => RestaurantCampaignModel.fromJson(campaign)).toList();
    return campaigns;
  }
}
