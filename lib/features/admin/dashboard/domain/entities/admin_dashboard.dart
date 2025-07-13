class AdminDashboardEntity {
  final AdminDashboardDataEntity today;
  final AdminDashboardDataEntity monthly;

  AdminDashboardEntity({
    required this.today,
    required this.monthly,
  });
}

class AdminDashboardDataEntity {
  final AdminRequestQueryEntity requests;
  final AdminRequestQueryEntity queries;

  AdminDashboardDataEntity({
    required this.requests,
    required this.queries,
  });
}

class AdminRequestQueryEntity {
  final int total;
  final int approved;
  final int rejected;
  final int pending;

  AdminRequestQueryEntity({
    required this.total,
    required this.approved,
    required this.rejected,
    required this.pending,
  });
}
