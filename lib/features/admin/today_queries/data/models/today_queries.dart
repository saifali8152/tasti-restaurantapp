import 'package:tasti_restaurant_app/core/models/pagination.dart';
import 'package:tasti_restaurant_app/features/admin/today_queries/domain/entities/today_queries.dart';

class TodayQueriesModel extends TodayQueriesEntity {
  const TodayQueriesModel({
    required super.data,
    required super.pagination,
  });

  factory TodayQueriesModel.fromJson(Map<String, dynamic> json) {
    return TodayQueriesModel(
      data: List<TodayQueriesItemModel>.from(
        json['data'].map((item) => TodayQueriesItemModel.fromJson(item)),
      ),
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => (e as TodayQueriesItemModel).toJson()).toList(),
      'pagination': (pagination as TodayQueriesItemModel).toJson(),
    };
  }
}

class TodayQueriesItemModel extends TodayQueriesItem {
  const TodayQueriesItemModel({
    required super.reqId,
  });

  factory TodayQueriesItemModel.fromJson(Map<String, dynamic> json) {
    return TodayQueriesItemModel(
      reqId: json['req_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'req_id': reqId,
    };
  }

  @override
  List<Object?> get props => [
        reqId,
      ];
}
