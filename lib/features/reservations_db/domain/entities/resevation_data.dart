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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ReservationDataEntity &&
        other.customerName == customerName &&
        other.customerEmail == customerEmail &&
        other.customerPhone == customerPhone &&
        other.reservationCount == reservationCount &&
        other.lastReservation == lastReservation &&
        other.lastReservationFormatted == lastReservationFormatted &&
        other.isManual == isManual &&
        other.type == type &&
        other.groupKey == groupKey &&
        other.hasEmail == hasEmail &&
        other.hasPhone == hasPhone;
  }

  @override
  int get hashCode => Object.hash(
        customerName,
        customerEmail,
        customerPhone,
        reservationCount,
        lastReservation,
        lastReservationFormatted,
        isManual,
        type,
        groupKey,
        hasEmail,
        hasPhone,
      );
}
