import '/features/admin/campaigns/domain/entities/campaigns.dart';

class CampaignsModel extends CampaignsEntity {
  const CampaignsModel({
    required super.id,
    required super.count,
    required super.name,
    required super.area,
    required super.dates,
    required super.totalCampaigns,
    required super.pendingApproval,
    required super.approved,
    required super.uniqueRecipientsCount,
  });

  factory CampaignsModel.fromJson(Map<String, dynamic> json) {
    return CampaignsModel(
      id: json['id'],
      count: json['count']??0,
      name: json['name'].toString(),
      area: json['area'].toString(),
      dates: json['dates'].toString(),
      totalCampaigns: json['total_campaigns']??0,
      pendingApproval: json['pending_approval']??0,
      approved: json['approved']??0,
      uniqueRecipientsCount: json['unique_recipients_count']??0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'count': count,
      'name': name,
      'area': area,
      'dates': dates,
      'total_campaigns': totalCampaigns,
      'pending_approval': pendingApproval,
      'approved': approved,
      'unique_recipients_count': uniqueRecipientsCount,
    };
  }
}
