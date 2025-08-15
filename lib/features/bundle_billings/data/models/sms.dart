import 'package:tasti_restaurant_app/features/bundle_billings/domain/entities/sms.dart';

class SMSModel extends SMSEntity {
  SMSModel({
    required super.id,
    required super.productOwner,
    required super.discount,
    required super.percentage,
    required super.bundles,
    required super.amount,
  });

  factory SMSModel.fromJson(Map<String, dynamic> json) {
    return SMSModel(
      id: json['id'] ?? 0,
      productOwner: json['product_owner'].toString(),
      discount: json['discount'].toString(),
      percentage: json['percentage'].toString(),
      bundles: json['bundles'].toString(),
      amount: json['amount'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_owner': productOwner,
      'discount': discount,
      'percentage': percentage,
      'bundles': bundles,
      'amount': amount,
    };
  }
}