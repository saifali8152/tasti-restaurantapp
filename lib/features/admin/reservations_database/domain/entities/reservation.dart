import 'package:equatable/equatable.dart';

class AdminReservationEntity extends Equatable {
  final List<AdminReservationItem> data;
  final ReservationPagination pagination;

  const AdminReservationEntity({
    required this.data,
    required this.pagination,
  });

  @override
  List<Object?> get props => [data, pagination];
}

class AdminReservationItem extends Equatable {
  final String guestName;
  final String email;
  final String phone;
  final String restaurantName;
  final int numGuests;
  final int reservationTime; // UNIX timestamp
  final String reservationTimeFormatted;

  const AdminReservationItem({
    required this.guestName,
    required this.email,
    required this.phone,
    required this.restaurantName,
    required this.numGuests,
    required this.reservationTime,
    required this.reservationTimeFormatted,
  });

  @override
  List<Object?> get props => [
        guestName,
        email,
        phone,
        restaurantName,
        numGuests,
        reservationTime,
        reservationTimeFormatted,
      ];
}

class ReservationPagination extends Equatable {
  final int currentPage;
  final int perPage;
  final int total;
  final int totalPages;
  final bool hasNext;
  final bool hasPrev;

  const ReservationPagination({
    required this.currentPage,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrev,
  });

  @override
  List<Object?> get props => [
        currentPage,
        perPage,
        total,
        totalPages,
        hasNext,
        hasPrev,
      ];
}
