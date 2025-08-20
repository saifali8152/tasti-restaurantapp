import 'package:flutter/material.dart';
import '/features/restaurant-admin/bundle_billings/domain/entities/bundle.dart';
import '/core/utils/general_extentions.dart';
import '/core/widgets/card_details_row.dart';

class BundleCard extends StatelessWidget {
  final BundleItem bundle;
  const BundleCard({
    super.key,
    required this.bundle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withSafeOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardDetailsRow(label: 'S.No', value: bundle.bundleId.toString()),
          CardDetailsRow(label: 'Product', value: bundle.productB),
          CardDetailsRow(label: 'Quantity', value: bundle.productQ.toString()),
          CardDetailsRow(label: 'Source', value: bundle.source),
          CardDetailsRow(label: 'Method', value: bundle.methods),
          CardDetailsRow(label: 'Amount', value: bundle.amount.toString()),
          CardDetailsRow(label: 'Date', value: bundle.dates),
          CardDetailsRow(label: 'Time', value: bundle.times),
        ],
      ),
    );
  }
}
