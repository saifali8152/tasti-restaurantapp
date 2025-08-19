// ENTITY
class ReservationDataEntity {
  final String customerName;
  final String? customerEmail;
  final String customerPhone;
  final int reservationCount;
  final int lastReservation;
  final String lastReservationFormatted;
  final bool isManual;
  final String type;
  final String groupKey;
  final bool hasEmail;
  final bool hasPhone;

  ReservationDataEntity({
    required this.customerName,
    this.customerEmail,
    required this.customerPhone,
    required this.reservationCount,
    required this.lastReservation,
    required this.lastReservationFormatted,
    required this.isManual,
    required this.type,
    required this.groupKey,
    required this.hasEmail,
    required this.hasPhone,
  });
}
