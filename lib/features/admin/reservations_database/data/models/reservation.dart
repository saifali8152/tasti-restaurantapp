import '/features/admin/reservations_database/domain/entities/reservation.dart';

class AdminReservationModel extends AdminReservationEntity {
  const AdminReservationModel({
    required List<AdminReservationItemModel> data,
    required ReservationPaginationModel pagination,
  }) : super(data: data, pagination: pagination);

  factory AdminReservationModel.fromJson(Map<String, dynamic> json) {
    return AdminReservationModel(
      data: List<AdminReservationItemModel>.from(
        json['data'].map((item) => AdminReservationItemModel.fromJson(item)),
      ),
      pagination: ReservationPaginationModel.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => (e as AdminReservationItemModel).toJson()).toList(),
      'pagination': (pagination as ReservationPaginationModel).toJson(),
    };
  }
}

class AdminReservationItemModel extends AdminReservationItem {
  const AdminReservationItemModel({
    required super.guestName,
    required super.email,
    required super.phone,
    required super.restaurantName,
    required super.numGuests,
    required super.reservationTime,
    required super.reservationTimeFormatted,
  });

  factory AdminReservationItemModel.fromJson(Map<String, dynamic> json) {
    return AdminReservationItemModel(
      guestName: json['guest_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      restaurantName: json['restaurant_name'] ?? '',
      numGuests: json['num_guests'] ?? 0,
      reservationTime: json['reservation_time'] ?? 0,
      reservationTimeFormatted: json['reservation_time_formatted'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'guest_name': guestName,
      'email': email,
      'phone': phone,
      'restaurant_name': restaurantName,
      'num_guests': numGuests,
      'reservation_time': reservationTime,
      'reservation_time_formatted': reservationTimeFormatted,
    };
  }
}

class ReservationPaginationModel extends ReservationPagination {
  const ReservationPaginationModel({
    required super.currentPage,
    required super.perPage,
    required super.total,
    required super.totalPages,
    required super.hasNext,
    required super.hasPrev,
  });

  factory ReservationPaginationModel.fromJson(Map<String, dynamic> json) {
    return ReservationPaginationModel(
      currentPage: json['current_page'] ?? 1,
      perPage: json['per_page'] ?? 10,
      total: json['total'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
      hasNext: json['has_next'] ?? false,
      hasPrev: json['has_prev'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'per_page': perPage,
      'total': total,
      'total_pages': totalPages,
      'has_next': hasNext,
      'has_prev': hasPrev,
    };
  }
}
