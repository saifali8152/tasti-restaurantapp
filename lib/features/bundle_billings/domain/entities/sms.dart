class SMSEntity {
  final int id;
  final String productOwner;
  final String discount;
  final String percentage;
  final String bundles;
  final String amount;

  SMSEntity({
    required this.id,
    required this.productOwner,
    required this.discount,
    required this.percentage,
    required this.bundles,
    required this.amount,
  });

  /// Returns true if discount is greater than 0
  bool get hasDiscount {
    final discountValue = double.tryParse(discount) ?? 0;
    return discountValue > 0;
  }

  /// Original price (before discount)
  String get originalPrice => percentage;

  /// Price to display (discounted if available)
  String get displayPrice => hasDiscount ? discount : percentage;
}
