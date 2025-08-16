import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/restaurant_campaign.dart';
import '/core/network/response.dart';

class RestaurantCampaignsState extends Equatable {
  final ApiResponse<List<RestaurantCampaignEntity>> fetchResponse;

  const RestaurantCampaignsState({required this.fetchResponse});

  RestaurantCampaignsState copyWith({
    final ApiResponse<List<RestaurantCampaignEntity>>? fetchResponse,
  }) {
    return RestaurantCampaignsState(
      fetchResponse: fetchResponse ?? this.fetchResponse,
    );
  }

  @override
  List<Object?> get props => [fetchResponse];
}
