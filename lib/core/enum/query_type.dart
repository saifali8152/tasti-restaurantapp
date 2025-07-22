enum QueryType {
  todayQueries,
  monthlyQueries,
  overallQueries,
}

extension QueryTypeExtension on QueryType {
  String get title {
    switch (this) {
      case QueryType.todayQueries:
        return "Today's Queries";
      case QueryType.monthlyQueries:
        return "Monthly Queries";
      case QueryType.overallQueries:
        return "Overall Queries";
    }
  }

  int get index {
    return this.index; 
  }
}
