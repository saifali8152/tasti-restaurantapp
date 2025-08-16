// MODEL
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/restaurant_campaign.dart';

class RestaurantCampaignModel extends RestaurantCampaignEntity {
  RestaurantCampaignModel({
    required super.cId,
    required super.people,
    required super.sms,
    required super.area,
    required super.message,
    required super.cash,
    required super.status,
    required super.dates,
    required super.reference,
  });

  factory RestaurantCampaignModel.fromJson(Map<String, dynamic> json) {
    return RestaurantCampaignModel(
      cId: json['c_id'] as int,
      people: json['people'] as int,
      sms: json['sms'] as String,
      area: json['area'] as String,
      message: json['message'] as String,
      cash: (json['cash'] as num).toDouble(),
      status: json['status'] as String,
      dates: json['dates'] as String,
      reference: json['reference'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'c_id': cId,
      'people': people,
      'sms': sms,
      'area': area,
      'message': message,
      'cash': cash,
      'status': status,
      'dates': dates,
      'reference': reference,
    };
  }
}
