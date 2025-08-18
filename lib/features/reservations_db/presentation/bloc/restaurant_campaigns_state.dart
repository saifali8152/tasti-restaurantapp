import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/restaurant_campaign.dart';
import '/core/network/response.dart';

class RestaurantCampaignsState extends Equatable {
  final ApiResponse<List<RestaurantCampaignEntity>> fetchResponse;
  final ApiResponse<String> importResponse;

  const RestaurantCampaignsState({
    required this.fetchResponse,
    required this.importResponse,
  });

  RestaurantCampaignsState copyWith({
    final ApiResponse<List<RestaurantCampaignEntity>>? fetchResponse,
    final ApiResponse<String>? importResponse,
  }) {
    return RestaurantCampaignsState(
      fetchResponse: fetchResponse ?? this.fetchResponse,
      importResponse: importResponse ?? this.importResponse,
    );
  }

  @override
  List<Object?> get props => [fetchResponse, importResponse];
}
