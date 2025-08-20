import '/features/restaurant-admin/bundle_billings/domain/entities/bundle.dart';
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
  final String? extraNote; // Example of additional property

  const BundleItemModel({
    required super.bundleId,
    required super.productB,
    required super.productQ,
    required super.source,
    required super.methods,
    required super.amount,
    required super.dates,
    required super.times,
    required super.resId,
    required super.reference,
    this.extraNote,
  });

  factory BundleItemModel.fromJson(Map<String, dynamic> json) {
    return BundleItemModel(
      bundleId: json['bundle_id'] as int,
      productB: json['product_b'] as String,
      productQ: json['product_q'] as int,
      source: json['source_'] as String,
      methods: json['methods'] as String,
      amount: (json['amount'] as num).toDouble(),
      dates: json['dates'] as String,
      times: json['times'] as String,
      resId: json['res_id'] as int,
      reference: json['reference'] as String,
      extraNote: json['extra_note'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    map['extra_note'] = extraNote;
    return map;
  }
}
