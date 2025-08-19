// MODEL
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/reservation_data_email.dart';

class ReservationDataEmailModel extends ReservationDataEmailEntity {
  ReservationDataEmailModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.guests,
    required super.reservation,
    required super.reservationStarts,
    required super.reservationEnds,
    required super.notes,
    required super.dietary,
    required super.occasion,
    required super.request,
    required super.waiter,
    super.status,
    required super.canceled,
    super.actionDate,
    required super.createdAt,
    required super.updatedAt,
    super.profitMoney,
    required super.formattedStartTime,
    required super.formattedEndTime,
    required super.formattedDateTime,
    required super.hasSpecialNotes,
    required super.statusDisplay,
    required super.canAssignWaiter,
  });

  factory ReservationDataEmailModel.fromJson(Map<String, dynamic> json) {
    return ReservationDataEmailModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      guests: json['guests'] ?? 0,
      reservation: json['reservation'] ?? 0,
      reservationStarts: json['reservation_starts'] ?? '',
      reservationEnds: json['reservation_ends'] ?? '',
      notes: json['notes'] ?? '',
      dietary: json['dietary'] ?? '',
      occasion: json['occasion'] ?? '',
      request: json['request'] ?? '',
      waiter: json['waiter'] ?? '',
      status: json['status'],
      canceled: json['canceled'] ?? 0,
      actionDate: json['action_date'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      profitMoney: json['profit_money']?.toString(),
      formattedStartTime: json['formatted_start_time'] ?? '',
      formattedEndTime: json['formatted_end_time'] ?? '',
      formattedDateTime: json['formatted_date_time'] ?? '',
      hasSpecialNotes: json['has_special_notes'] ?? false,
      statusDisplay: json['status_display'] ?? '',
      canAssignWaiter: json['can_assign_waiter'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "phone": phone,
      "guests": guests,
      "reservation": reservation,
      "reservation_starts": reservationStarts,
      "reservation_ends": reservationEnds,
      "notes": notes,
      "dietary": dietary,
      "occasion": occasion,
      "request": request,
      "waiter": waiter,
      "status": status,
      "canceled": canceled,
      "action_date": actionDate,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "profit_money": profitMoney,
      "formatted_start_time": formattedStartTime,
      "formatted_end_time": formattedEndTime,
      "formatted_date_time": formattedDateTime,
      "has_special_notes": hasSpecialNotes,
      "status_display": statusDisplay,
      "can_assign_waiter": canAssignWaiter,
    };
  }
}
