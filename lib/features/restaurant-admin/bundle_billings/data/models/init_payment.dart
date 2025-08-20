import '/features/restaurant-admin/bundle_billings/domain/entities/init_payment.dart';

class InitPaymentModel extends InitPaymentEntity {
  const InitPaymentModel({
    required super.authorizationUrl,
    required super.reference,
    required super.amount,
    required super.currency,
    required super.bundleDetails,
  });

  factory InitPaymentModel.fromJson(Map<String, dynamic> json) {
    return InitPaymentModel(
      authorizationUrl: json['authorization_url'] ?? '',
      reference: json['reference'] ?? '',
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] ?? '',
      bundleDetails: BundleDetailsModel.fromJson(json['bundle_details'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'authorization_url': authorizationUrl,
      'reference': reference,
      'amount': amount,
      'currency': currency,
      'bundle_details': (bundleDetails as BundleDetailsModel).toJson(),
    };
  }
}

class BundleDetailsModel extends BundleDetailsEntity {
  const BundleDetailsModel({
    required super.id,
    required super.bundles,
    required super.productOwner,
    required super.hasDiscount,
    required super.discountPercentage,
  });

  factory BundleDetailsModel.fromJson(Map<String, dynamic> json) {
    return BundleDetailsModel(
      id: json['id'] ?? 0,
      bundles: json['bundles'] ?? 0,
      productOwner: json['product_owner'] ?? '',
      hasDiscount: json['has_discount'] ?? false,
      discountPercentage: json['discount_percentage'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bundles': bundles,
      'product_owner': productOwner,
      'has_discount': hasDiscount,
      'discount_percentage': discountPercentage,
    };
  }
}
