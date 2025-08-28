class ReservationEntity {
  final List<ReservationItem> data;
  final StatsItem stats;
  final int total;

  ReservationEntity({
    required this.data,
    required this.stats,
    required this.total,
  });
}

class ReservationItem {
  final int id;
  final String name;
  final String phone;
  final int guests;
  final int reservation;
  final String reservationStarts;
  final String reservationEnds;
  final String notes;
  final String dietary;
  final String occasion;
  final String request;
  final String waiter;
  final String? status;
  final int canceled;
  final String? actionDate;
  final String createdAt;
  final String updatedAt;
  final double? profitMoney;
  final String formattedStartTime;
  final String formattedEndTime;
  final String formattedDateTime;
  final bool hasSpecialNotes;
  final String statusDisplay;
  final bool canAssignWaiter;
  final bool isConfirmed;

  ReservationItem({
    required this.id,
    required this.isConfirmed,
    required this.name,
    required this.phone,
    required this.guests,
    required this.reservation,
    required this.reservationStarts,
    required this.reservationEnds,
    required this.notes,
    required this.dietary,
    required this.occasion,
    required this.request,
    required this.waiter,
    required this.status,
    required this.canceled,
    required this.actionDate,
    required this.createdAt,
    required this.updatedAt,
    required this.profitMoney,
    required this.formattedStartTime,
    required this.formattedEndTime,
    required this.formattedDateTime,
    required this.hasSpecialNotes,
    required this.statusDisplay,
    required this.canAssignWaiter,
  });

  ReservationItem copyWith({
    String? statusDisplay,
    bool? isConfirmed,
  }) {
    return ReservationItem(
      id: id,
      isConfirmed: isConfirmed?? this.isConfirmed,
      name: name,
      phone: phone,
      guests: guests,
      reservation: reservation,
      reservationStarts: reservationStarts,
      reservationEnds: reservationEnds,
      notes: notes,
      dietary: dietary,
      occasion: occasion,
      request: request,
      waiter: waiter,
      status: status,
      canceled: canceled,
      actionDate: actionDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
      profitMoney: profitMoney,
      formattedStartTime: formattedStartTime,
      formattedEndTime: formattedEndTime,
      formattedDateTime: formattedDateTime,
      hasSpecialNotes: hasSpecialNotes,
      statusDisplay: statusDisplay ?? this.statusDisplay,
      canAssignWaiter: canAssignWaiter,
    );
  }
}

class StatsItem {
  final int totalBookings;
  final int totalPax;

  StatsItem({
    required this.totalBookings,
    required this.totalPax,
  });
}
