import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/domain/entities/transaction_history.dart';
import '/core/utils/general_extentions.dart';
import '/core/widgets/card_details_row.dart';

class TransactionCard extends StatelessWidget {
  final RestaurantTransactionHistoryItem transactionHistory;
  const TransactionCard({
    super.key,
    required this.transactionHistory,
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
          CardDetailsRow(label: 'S.No', value: transactionHistory.id.toString()),
          CardDetailsRow(label: 'Reference', value: transactionHistory.reference),
          CardDetailsRow(label: 'Amount', value: transactionHistory.amount),
          CardDetailsRow(label: 'Status', value: transactionHistory.status),
          CardDetailsRow(label: 'Date', value: transactionHistory.date),
        ],
      ),
    );
  }
}
