import '../../domain/entities/dashboard.dart';

class DashboardModel extends DashboardEntity {
  DashboardModel({
    required DashboardDataModel super.today,
    required DashboardDataModel super.monthly,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    final dashboard = json['dashboard'] as Map<String, dynamic>;
    return DashboardModel(
      today: DashboardDataModel.fromJson(dashboard['today']),
      monthly: DashboardDataModel.fromJson(dashboard['monthly']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dashboard': {
        'today': (today as DashboardDataModel).toJson(),
        'monthly': (monthly as DashboardDataModel).toJson(),
      },
    };
  }
}

class DashboardDataModel extends DashboardDataEntity {
  DashboardDataModel({
    required super.requests,
    required super.queries,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) {
    return DashboardDataModel(
      requests: RequestQueryModel.fromJson(json['requests']),
      queries: RequestQueryModel.fromJson(json['queries']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requests': (requests as RequestQueryModel).toJson(),
      'queries': (queries as RequestQueryModel).toJson(),
    };
  }
}

class RequestQueryModel extends RequestQueryEntity {
  RequestQueryModel({
    required super.total,
    required super.approved,
    required super.rejected,
    required super.pending,
  });

  factory RequestQueryModel.fromJson(Map<String, dynamic> json) {
    return RequestQueryModel(
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
