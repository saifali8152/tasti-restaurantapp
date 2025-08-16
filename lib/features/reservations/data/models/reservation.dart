import 'package:tasti_restaurant_app/features/reservations/domain/entities/reservation.dart';

class ReservationModel extends ReservationEntity {
  ReservationModel({
    required List<ReservationItemModel> super.data,
    required StatsItemModel super.stats,
    required super.total,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => ReservationItemModel.fromJson(e))
          .toList(),
      stats: StatsItemModel.fromJson(json['stats']),
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => (e as ReservationItemModel).toJson()).toList(),
      'stats': (stats as StatsItemModel).toJson(),
      'total': total,
    };
  }
}

class ReservationItemModel extends ReservationItem {
  ReservationItemModel({
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
    required super.status,
    required super.canceled,
    required super.actionDate,
    required super.createdAt,
    required super.updatedAt,
    required super.profitMoney,
    required super.formattedStartTime,
    required super.formattedEndTime,
    required super.formattedDateTime,
    required super.hasSpecialNotes,
    required super.statusDisplay,
    required super.canAssignWaiter,
  });

  factory ReservationItemModel.fromJson(Map<String, dynamic> json) {
    return ReservationItemModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      guests: json['guests'],
      reservation: json['reservation'],
      reservationStarts: json['reservation_starts'],
      reservationEnds: json['reservation_ends'],
      notes: json['notes'],
      dietary: json['dietary'],
      occasion: json['occasion'],
      request: json['request'],
      waiter: json['waiter'],
      status: json['status'],
      canceled: json['canceled'],
      actionDate: json['action_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      profitMoney: json['profit_money'] != null
          ? (json['profit_money'] as num).toDouble()
          : null,
      formattedStartTime: json['formatted_start_time'],
      formattedEndTime: json['formatted_end_time'],
      formattedDateTime: json['formatted_date_time'],
      hasSpecialNotes: json['has_special_notes'],
      statusDisplay: json['status_display'],
      canAssignWaiter: json['can_assign_waiter'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'guests': guests,
      'reservation': reservation,
      'reservation_starts': reservationStarts,
      'reservation_ends': reservationEnds,
      'notes': notes,
      'dietary': dietary,
      'occasion': occasion,
      'request': request,
      'waiter': waiter,
      'status': status,
      'canceled': canceled,
      'action_date': actionDate,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'profit_money': profitMoney,
      'formatted_start_time': formattedStartTime,
      'formatted_end_time': formattedEndTime,
      'formatted_date_time': formattedDateTime,
      'has_special_notes': hasSpecialNotes,
      'status_display': statusDisplay,
      'can_assign_waiter': canAssignWaiter,
    };
  }
}

class StatsItemModel extends StatsItem {
  StatsItemModel({
    required super.totalBookings,
    required super.totalPax,
  });

  factory StatsItemModel.fromJson(Map<String, dynamic> json) {
    return StatsItemModel(
      totalBookings: json['total_bookings'],
      totalPax: json['total_pax'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_bookings': totalBookings,
      'total_pax': totalPax,
    };
  }
}
