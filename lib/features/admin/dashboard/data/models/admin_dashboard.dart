import '../../domain/entities/admin_dashboard.dart';

class AdminDashboardModel extends AdminDashboardEntity {
  AdminDashboardModel({
    required AdminDashboardDataModel today,
    required AdminDashboardDataModel monthly,
  }) : super(today: today, monthly: monthly);

  factory AdminDashboardModel.fromJson(Map<String, dynamic> json) {
    final dashboard = json['dashboard'] as Map<String, dynamic>;
    return AdminDashboardModel(
      today: AdminDashboardDataModel.fromJson(dashboard['today']),
      monthly: AdminDashboardDataModel.fromJson(dashboard['monthly']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dashboard': {
        'today': (today as AdminDashboardDataModel).toJson(),
        'monthly': (monthly as AdminDashboardDataModel).toJson(),
      },
    };
  }
}

class AdminDashboardDataModel extends AdminDashboardDataEntity {
  AdminDashboardDataModel({
    required AdminRequestQueryModel requests,
    required AdminRequestQueryModel queries,
  }) : super(requests: requests, queries: queries);

  factory AdminDashboardDataModel.fromJson(Map<String, dynamic> json) {
    return AdminDashboardDataModel(
      requests: AdminRequestQueryModel.fromJson(json['requests']),
      queries: AdminRequestQueryModel.fromJson(json['queries']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requests': (requests as AdminRequestQueryModel).toJson(),
      'queries': (queries as AdminRequestQueryModel).toJson(),
    };
  }
}

class AdminRequestQueryModel extends AdminRequestQueryEntity {
  AdminRequestQueryModel({
    required super.total,
    required super.approved,
    required super.rejected,
    required super.pending,
  });

  factory AdminRequestQueryModel.fromJson(Map<String, dynamic> json) {
    return AdminRequestQueryModel(
      total: json['total'],
      approved: json['approved'],
      rejected: json['rejected'],
      pending: json['pending'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'approved': approved,
      'rejected': rejected,
      'pending': pending,
    };
  }
}
