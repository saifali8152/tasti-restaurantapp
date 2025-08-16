import 'package:equatable/equatable.dart';
import '/core/models/pagination.dart';

class BundleEntity extends Equatable {
  final List<BundleItem> data;
  final PaginationModel pagination;

  const BundleEntity({
    required this.data,
    required this.pagination,
  });

  @override
  List<Object?> get props => [data, pagination];
}

class BundleItem {
  final int bundleId;
  final String productB;
  final int productQ;
  final String source;
  final String methods;
  final double amount;
  final String dates;
  final String times;
  final int resId;
  final String reference;

  const BundleItem({
    required this.bundleId,
    required this.productB,
    required this.productQ,
    required this.source,
    required this.methods,
    required this.amount,
    required this.dates,
    required this.times,
    required this.resId,
    required this.reference,
  });

  factory BundleItem.fromJson(Map<String, dynamic> json) {
    return BundleItem(
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bundle_id': bundleId,
      'product_b': productB,
      'product_q': productQ,
      'source_': source,
      'methods': methods,
      'amount': amount,
      'dates': dates,
      'times': times,
      'res_id': resId,
      'reference': reference,
    };
  }
}
