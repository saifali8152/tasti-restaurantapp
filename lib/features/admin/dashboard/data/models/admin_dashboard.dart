import 'package:tasti_restaurant_app/features/admin/dashboard/domain/entities/admin_dashboard.dart';

class DashboardModel {
  final DashboardDataModel today;
  final DashboardDataModel monthly;

  DashboardModel({
    required this.today,
    required this.monthly,
  });

  factory DashboardModel.fromJson(Map<String, dynamic>? json) {
    final dashboard = json?['dashboard'] as Map<String, dynamic>?;

    return DashboardModel(
      today: DashboardDataModel.fromJson(dashboard?['today']),
      monthly: DashboardDataModel.fromJson(dashboard?['monthly']),
    );
  }

  Map<String, dynamic> toJson() => {
        'dashboard': {
          'today': today.toJson(),
          'monthly': monthly.toJson(),
        },
      };

  /// Converts Model to Entity
  AdminDashboardEntity toEntity() => AdminDashboardEntity(
        today: today.toEntity(),
        monthly: monthly.toEntity(),
      );
}

class DashboardDataModel {
  final RequestQueryModel requests;
  final RequestQueryModel queries;

  DashboardDataModel({
    required this.requests,
    required this.queries,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic>? json) {
    return DashboardDataModel(
      requests: RequestQueryModel.fromJson(json?['requests']),
      queries: RequestQueryModel.fromJson(json?['queries']),
    );
  }

  Map<String, dynamic> toJson() => {
        'requests': requests.toJson(),
        'queries': queries.toJson(),
      };

  AdminDashboardDataEntity toEntity() => AdminDashboardDataEntity(
        requests: requests.toEntity(),
        queries: queries.toEntity(),
      );
}

class RequestQueryModel {
  final int total;
  final int approved;
  final int rejected;
  final int pending;

  RequestQueryModel({
    required this.total,
    required this.approved,
    required this.rejected,
    required this.pending,
  });

  factory RequestQueryModel.fromJson(Map<String, dynamic>? json) {
    return RequestQueryModel(
      total: _toInt(json, 'total'),
      approved: _toInt(json, 'approved'),
      rejected: _toInt(json, 'rejected'),
      pending: _toInt(json, 'pending'),
    );
  }

  Map<String, dynamic> toJson() => {
        'total': total,
        'approved': approved,
        'rejected': rejected,
        'pending': pending,
      };

  AdminRequestQueryEntity toEntity() => AdminRequestQueryEntity(
        total: total,
        approved: approved,
        rejected: rejected,
        pending: pending,
      );

  static int _toInt(Map<String, dynamic>? json, String key) {
    if (json == null) return 0;
    final value = json[key];

    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is double) return value.toInt();

    return 0;
  }
}
