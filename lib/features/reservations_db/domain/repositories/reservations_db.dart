import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/restaurant_campaign.dart';
import '/core/network/response.dart';

abstract class IReservationDbRepo {
  Future<DataState<List<RestaurantCampaignEntity>>> fetchRestaurantCampaigns(String id);
}
