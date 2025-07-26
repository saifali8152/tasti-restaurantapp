class DashboardEntity {
  final DashboardDataEntity today;
  final DashboardDataEntity monthly;

  DashboardEntity({
    required this.today,
    required this.monthly,
  });
}

class DashboardDataEntity {
  final RequestQueryEntity requests;
  final RequestQueryEntity queries;

  DashboardDataEntity({
    required this.requests,
    required this.queries,
  });
}

class RequestQueryEntity {
  final int total;
  final int approved;
  final int rejected;
  final int pending;

  RequestQueryEntity({
    required this.total,
    required this.approved,
    required this.rejected,
    required this.pending,
  });
}
