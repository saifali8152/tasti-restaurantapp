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

  CampaignsByResEntity copyWith({
  int? cId,
  String? people,
  String? dates,
  String? area,
  String? status,
  String? cash,
}) {
  return CampaignsByResEntity(
    cId: cId ?? this.cId,
    people: people ?? this.people,
    dates: dates ?? this.dates,
    area: area ?? this.area,
    status: status ?? this.status,
    cash: cash ?? this.cash,
  );
}


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
