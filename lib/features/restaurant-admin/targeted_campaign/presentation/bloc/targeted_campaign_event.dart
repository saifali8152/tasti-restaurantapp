import 'package:equatable/equatable.dart';
import '/core/parms/parms.dart';

abstract class TargetedCampaignEvent extends Equatable {
  const TargetedCampaignEvent();

  @override
  List<Object?> get props => [];
}
class InitCampaignPayment extends TargetedCampaignEvent {
  final int bundleId;

  const InitCampaignPayment(this.bundleId);
}

class VerifyCampaignPayment extends TargetedCampaignEvent {
  final VerifyCampaignPaymentParms parms;

  const VerifyCampaignPayment(this.parms);
}

class AddTargetedCampaignEvent extends TargetedCampaignEvent {
  final AddTargetedCampaignParms parms;

  const AddTargetedCampaignEvent(this.parms);
}