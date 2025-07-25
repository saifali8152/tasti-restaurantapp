import 'package:flutter/material.dart';
import '/core/widgets/card_details_row.dart';
import '/features/admin/transaction_history/domain/entities/transaction_history.dart';

class TransactionHistoryCard extends StatelessWidget {
  final TransactionHistoryItem item;
  const TransactionHistoryCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            CardDetailsRow(label: 'Id', value: item.id.toString()),
            CardDetailsRow(label: 'User', value: item.userId.toString()),
            CardDetailsRow(label: 'Reference', value: item.reference, flex: 1),
            CardDetailsRow(label: 'Amount', value: item.amount),
            CardDetailsRow(label: 'Status', value: item.status),
            CardDetailsRow(label: 'Transaction Date', value: item.transactionDate),
          ],
        ),
      ),
    );
  }
}
