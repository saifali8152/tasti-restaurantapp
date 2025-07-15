import 'package:flutter/material.dart';
import '/core/utils/general_extentions.dart';
import '/core/widgets/details_row.dart';
import '/core/widgets/custom_app_bar.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Transaction History'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DetailsRow(title: "User", value: "Tasti"),
            DetailsRow(title: "Reference", value: "Umar"),
            DetailsRow(title: "Amount", value: "1000"),
            DetailsRow(title: "Status", value: "success"),
            DetailsRow(title: "Transaction Date", value: DateTime.now().formatDate()),
          ],
        ),
      ),
    );
  }
}
