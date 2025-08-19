import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/resevation_data.dart';

class ReservationDataModel extends ReservationDataEntity {
  ReservationDataModel({
    required super.customerName,
    super.customerEmail,
    required super.customerPhone,
    required super.reservationCount,
    required super.lastReservation,
    required super.lastReservationFormatted,
    required super.isManual,
    required super.type,
    required super.groupKey,
    required super.hasEmail,
    required super.hasPhone,
  });

  factory ReservationDataModel.fromJson(Map<String, dynamic> json) {
    return ReservationDataModel(
      customerName: json['customer_name'] ?? '',
      customerEmail: json['customer_email'],
      customerPhone: json['customer_phone'] ?? '',
      reservationCount: json['reservation_count'] ?? 0,
      lastReservation: json['last_reservation'] ?? 0,
      lastReservationFormatted: json['last_reservation_formatted'] ?? '',
      isManual: json['is_manual'] ?? false,
      type: json['type'] ?? '',
      groupKey: json['group_key'] ?? '',
      hasEmail: json['has_email'] ?? false,
      hasPhone: json['has_phone'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "customer_name": customerName,
      "customer_email": customerEmail,
      "customer_phone": customerPhone,
      "reservation_count": reservationCount,
      "last_reservation": lastReservation,
      "last_reservation_formatted": lastReservationFormatted,
      "is_manual": isManual,
      "type": type,
      "group_key": groupKey,
      "has_email": hasEmail,
      "has_phone": hasPhone,
    };
  }
}
