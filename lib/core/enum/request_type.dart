enum RequestType {
  todayRequests,
  monthlyRequests,
  overallRequests,
}

extension RequestTypeExtension on RequestType {
  String get title {
    switch (this) {
      case RequestType.todayRequests:
        return "Today's Requests";
      case RequestType.monthlyRequests:
        return "Monthly Requests";
      case RequestType.overallRequests:
        return "Overall Requests";
    }
  }

  int get index {
    return this.index; 
  }
}
