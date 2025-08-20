import '/features/restaurant-admin/dashboard/domain/entities/dashboard.dart';

class DashboardModel extends DashboardEntity {
  DashboardModel({
    required StatsModel super.monthlyStats,
    required StatsModel super.todayStats,
    required StatsModel super.overallStats,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      monthlyStats: StatsModel.fromJson(json['monthly_stats'] ?? {}),
      todayStats: StatsModel.fromJson(json['today_stats'] ?? {}),
      overallStats: StatsModel.fromJson(json['overall_stats'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'monthly_stats': (monthlyStats as StatsModel).toJson(),
      'today_stats': (todayStats as StatsModel).toJson(),
      'overall_stats': (overallStats as StatsModel).toJson(),
    };
  }

  DashboardEntity toEntity() {
    return DashboardEntity(
      monthlyStats: monthlyStats,
      todayStats: todayStats,
      overallStats: overallStats,
    );
  }

  factory DashboardModel.fromEntity(DashboardEntity entity) {
    return DashboardModel(
      monthlyStats: StatsModel.fromEntity(entity.monthlyStats),
      todayStats: StatsModel.fromEntity(entity.todayStats),
      overallStats: StatsModel.fromEntity(entity.overallStats),
    );
  }

  DashboardModel copyWith({
    StatsModel? monthlyStats,
    StatsModel? todayStats,
    StatsModel? overallStats,
  }) {
    return DashboardModel(
      monthlyStats: monthlyStats ?? this.monthlyStats as StatsModel,
      todayStats: todayStats ?? this.todayStats as StatsModel,
      overallStats: overallStats ?? this.overallStats as StatsModel,
    );
  }
}
class StatsModel extends Stats {
  StatsModel({
    required super.reservationCount,
    required super.totalGuests,
    required super.avgCovers,
    required super.bookingCount,
  });

  factory StatsModel.fromJson(Map<String, dynamic> json) {
    return StatsModel(
      reservationCount: json['reservation_count']?.toString() ?? '0',
      totalGuests: json['total_guests']?.toString() ?? '0',
      avgCovers: json['avg_covers']?.toString() ?? '0.0',
      bookingCount: json['booking_count']?.toString() ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reservation_count': reservationCount,
      'total_guests': totalGuests,
      'avg_covers': avgCovers,
      'booking_count': bookingCount,
    };
  }

  factory StatsModel.fromEntity(Stats stats) {
    return StatsModel(
      reservationCount: stats.reservationCount,
      totalGuests: stats.totalGuests,
      avgCovers: stats.avgCovers,
      bookingCount: stats.bookingCount,
    );
  }

  Stats toEntity() {
    return Stats(
      reservationCount: reservationCount,
      totalGuests: totalGuests,
      avgCovers: avgCovers,
      bookingCount: bookingCount,
    );
  }

  StatsModel copyWith({
    String? reservationCount,
    String? totalGuests,
    String? avgCovers,
    String? bookingCount,
  }) {
    return StatsModel(
      reservationCount: reservationCount ?? this.reservationCount,
      totalGuests: totalGuests ?? this.totalGuests,
      avgCovers: avgCovers ?? this.avgCovers,
      bookingCount: bookingCount ?? this.bookingCount,
    );
  }
}
