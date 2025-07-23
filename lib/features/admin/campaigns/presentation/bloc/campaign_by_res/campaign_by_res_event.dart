import 'package:equatable/equatable.dart';

abstract class CampaignByResEvent extends Equatable {
  const CampaignByResEvent();

  @override
  List<Object?> get props => [];
}

class FetchCampaignsByRes extends CampaignByResEvent {
  final String id;

  const FetchCampaignsByRes(this.id);
}
