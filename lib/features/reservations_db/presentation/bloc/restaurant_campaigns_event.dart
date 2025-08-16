import 'package:equatable/equatable.dart';

abstract class RestaurantCampaignsEvent extends Equatable {
  const RestaurantCampaignsEvent();

  @override
  List<Object?> get props => [];
}

class FetchRestaurantCampaignsEvent extends RestaurantCampaignsEvent {
  final String id;

  const FetchRestaurantCampaignsEvent(this.id);
}