import 'package:tasti_restaurant_app/features/targeted_campaign/domain/entities/targeted_campaign.dart';

class TargetedCampaignModel extends TargetedCampaignEntity {
  TargetedCampaignModel({
    required super.tempId,
    required super.message,
    required super.total,
  });

  factory TargetedCampaignModel.fromJson(Map<String, dynamic> json) {
    return TargetedCampaignModel(
      tempId: json['temp_id'].toString(),
      total: json['total'].toString(),
      message: json['message'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'total': total,
      'temp_id': tempId,
    };
  }
}
