import '/features/admin/campaigns/domain/entities/campaigns_by_res.dart';

class CampaignsByResModel extends CampaignsByResEntity {
  const CampaignsByResModel({
    required super.cId,
    required super.people,
    required super.dates,
    required super.area,
    required super.cash,
    required super.status,
    required super.message,
    required super.sms,
    required super.reference,
  });

  factory CampaignsByResModel.fromJson(Map<String, dynamic> json) {
    return CampaignsByResModel(
      cId: json['c_id'],
      people: json['people'].toString(),
      area: json['area'].toString(),
      dates: json['dates'].toString(),
      cash: json['cash'].toString(),
      status: json['status'].toString(),
      message: json['message'].toString(),
      sms: json['sms'].toString(),
      reference: json['reference'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'c_id': cId,
      'people': people,
      'area': area,
      'dates': dates,
      'cash': cash,
      'status': status,
      'message': message,
      'sms': sms,
      'reference': reference,
    };
  }
}
