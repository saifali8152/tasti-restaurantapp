import 'package:equatable/equatable.dart';

class CampaignsEntity extends Equatable {
  final int id;
  final int count;
  final String name;
  final String area;
  final String dates;
  final int totalCampaigns;
  final int pendingApproval;
  final int approved;
  final int uniqueRecipientsCount;

  const CampaignsEntity({
    required this.id,
    required this.count,
    required this.name,
    required this.area,
    required this.dates,
    required this.totalCampaigns,
    required this.pendingApproval,
    required this.approved,
    required this.uniqueRecipientsCount,
  });

  @override
  List<Object?> get props => [
        id,
        count,
        name,
        area,
        dates,
        totalCampaigns,
        pendingApproval,
        approved,
        uniqueRecipientsCount,
      ];
}
