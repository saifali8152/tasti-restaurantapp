class InitPaymentEntity {
  final String authorizationUrl;
  final String reference;
  final double amount;
  final String currency;
  final BundleDetailsEntity bundleDetails;

  const InitPaymentEntity({
    required this.authorizationUrl,
    required this.reference,
    required this.amount,
    required this.currency,
    required this.bundleDetails,
  });
}

class BundleDetailsEntity {
  final int id;
  final int bundles;
  final String productOwner;
  final bool hasDiscount;
  final int discountPercentage;

  const BundleDetailsEntity({
    required this.id,
    required this.bundles,
    required this.productOwner,
    required this.hasDiscount,
    required this.discountPercentage,
  });
}
