import 'package:equatable/equatable.dart';

class CampaignsByResEntity extends Equatable {
  final int cId;
  final String people;
  final String dates;
  final String area;
  final String status;
  final String cash;
  final String message;
  final String sms;
  final String reference;

  const CampaignsByResEntity({
    required this.cId,
    required this.people,
    required this.dates,
    required this.area,
    required this.status,
    required this.cash,
    required this.message,
    required this.sms,
    required this.reference,
  });

  CampaignsByResEntity copyWith({
  int? cId,
  String? people,
  String? dates,
  String? area,
  String? status,
  String? cash,
  String? message,
  String? sms,
  String? reference
}) {
  return CampaignsByResEntity(
    cId: cId ?? this.cId,
    people: people ?? this.people,
    dates: dates ?? this.dates,
    area: area ?? this.area,
    status: status ?? this.status,
    cash: cash ?? this.cash,
    message: message ?? this.message,
    sms: sms ?? this.sms,
    reference: reference ?? this.reference,
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
