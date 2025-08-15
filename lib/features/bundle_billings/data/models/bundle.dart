import 'package:tasti_restaurant_app/features/bundle_billings/domain/entities/bundle.dart';
import '/core/models/pagination.dart';

class BundleModel extends BundleEntity {
  const BundleModel({
    required super.data,
    required super.pagination,
  });

  factory BundleModel.fromJson(Map<String, dynamic> json) {
    return BundleModel(
      data: List<BundleItemModel>.from(
        json['data'].map((item) => BundleItemModel.fromJson(item)),
      ),
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => (e as BundleItemModel).toJson()).toList(),
      'pagination': (pagination as BundleItemModel).toJson(),
    };
  }
}

class BundleItemModel extends BundleItem {
  const BundleItemModel({
    required super.eventId,
    required super.eventTitle,
    required super.eventImage,
    required super.eventLink,
  });

  factory BundleItemModel.fromJson(Map<String, dynamic> json) {
    return BundleItemModel(
      eventId: json['event_id'] ?? 0,
      eventTitle: json['event_title'] ?? '',
      eventImage: json['event_image'] ?? '',
      eventLink: json['event_link'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'event_title': eventTitle,
      'event_image': eventImage,
      'event_link': eventLink,
    };
  }
}
