import 'package:equatable/equatable.dart';
import '/core/parms/parms.dart';

abstract class RestaurantCampaignsEvent extends Equatable {
  const RestaurantCampaignsEvent();

  @override
  List<Object?> get props => [];
}

class FetchRestaurantCampaignsEvent extends RestaurantCampaignsEvent {
  final String id;

  const FetchRestaurantCampaignsEvent(this.id);
}

class ImportCSVFile extends RestaurantCampaignsEvent {
  final ImportCSVFileParms parms;

  const ImportCSVFile(this.parms);
}