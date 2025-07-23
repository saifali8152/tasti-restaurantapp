import 'package:equatable/equatable.dart';

abstract class CampaignEvent extends Equatable {
  const CampaignEvent();

  @override
  List<Object?> get props => [];
}

class FetchCampaigns extends CampaignEvent {}
