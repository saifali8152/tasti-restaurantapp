import 'package:equatable/equatable.dart';

class CampaignsByResEntity extends Equatable {
  final int cId;
  final String people;
  final String dates;
  final String area;
  final String status;
  final String cash;

  const CampaignsByResEntity({
    required this.cId,
    required this.people,
    required this.dates,
    required this.area,
    required this.status,
    required this.cash,
  });

  @override
  List<Object?> get props => [
        cId,
        people,
        dates,
        area,
        status,
        cash,
      ];
}
