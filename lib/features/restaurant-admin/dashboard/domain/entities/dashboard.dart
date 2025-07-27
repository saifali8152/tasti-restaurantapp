class DashboardEntity {
  final Stats monthlyStats;
  final Stats todayStats;
  final Stats overallStats;

  DashboardEntity({
    required this.monthlyStats,
    required this.todayStats,
    required this.overallStats,
  });

  factory DashboardEntity.fromJson(Map<String, dynamic> json) {
    return DashboardEntity(
      monthlyStats: Stats.fromJson(json['monthly_stats']),
      todayStats: Stats.fromJson(json['today_stats']),
      overallStats: Stats.fromJson(json['overall_stats']),
    );
  }
}

class Stats {
  final String reservationCount;
  final String totalGuests;
  final String avgCovers;
  final String bookingCount;

  Stats({
    required this.reservationCount,
    required this.totalGuests,
    required this.avgCovers,
    required this.bookingCount,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      reservationCount: json['reservation_count'].toString(),
      totalGuests: json['total_guests'].toString(),
      avgCovers: json['avg_covers'].toString(),
      bookingCount: json['booking_count'].toString(),
    );
  }
}