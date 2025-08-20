import '/features/restaurant-admin/reservations_db/domain/entities/restaurant_campaign.dart';
import '/features/restaurant-admin/reservations_db/domain/repositories/reservations_db.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchRestaurantCampaignsUsecase extends UseCase<DataState<List<RestaurantCampaignEntity>>, String>{
  final IReservationDbRepo repo;
  
  FetchRestaurantCampaignsUsecase(this.repo);

  @override
  Future<DataState<List<RestaurantCampaignEntity>>> call(id) {
    return repo.fetchRestaurantCampaigns(id);
  }
}