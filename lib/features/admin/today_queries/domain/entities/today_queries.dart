import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/models/pagination.dart';

class TodayQueriesEntity extends Equatable {
  final List<TodayQueriesItem> data;
  final PaginationModel pagination;

  const TodayQueriesEntity({
    required this.data,
    required this.pagination,
  });

  @override
  List<Object?> get props => [data, pagination];
}

class TodayQueriesItem extends Equatable {
  final int reqId;

  const TodayQueriesItem({
    required this.reqId,
  });

  @override
  List<Object?> get props => [
        reqId,
      ];
}
