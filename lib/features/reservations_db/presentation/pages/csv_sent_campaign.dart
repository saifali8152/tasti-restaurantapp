import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_app_bar.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_button.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_input_field.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/csv_data.dart';

class CsvSentCampaignArguments {
  final List<CSVDataEntity> data;
  final String response;

  CsvSentCampaignArguments(this.data, this.response);
}

class CsvSentCampaign extends StatefulWidget {
  final CsvSentCampaignArguments arguments;
  const CsvSentCampaign({super.key, required this.arguments});

  @override
  State<CsvSentCampaign> createState() => _CsvSentCampaignState();
}

class _CsvSentCampaignState extends State<CsvSentCampaign> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final recipients = widget.arguments.data.length;
    final smsBalance = widget.arguments.response;

    return Scaffold(
      appBar: CustomAppBar(title: "Campaign Manager"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar with recipients + balance
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Wrap(
                spacing: 16,
                runSpacing: 8,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.people, color: Colors.teal),
                      const SizedBox(width: 6),
                      Text(
                        "Recipients: $recipients",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.email, color: Colors.teal),
                      const SizedBox(width: 6),
                      Text(
                        "Balance: $smsBalance",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Campaign Subject
            const Text(
              "Campaign Subject",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            CustomInputField(
              controller: _subjectController,
              hintText: "Enter campaign subject/title",
            ),

            const SizedBox(height: 20),

            // Message Content
            const Text(
              "Message Content",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            CustomInputField(
              controller: _messageController,
              maxLines: 5,
              hintText: "Type your campaign message here...",
            ),

            const Spacer(),

            // Send button
            Hero(
              tag: "Send SMS/Email",
              child: Material(
                type: MaterialType.transparency,
                child: CustomButton(
                  onPressed: () {
                    final subject = _subjectController.text.trim();
                    final message = _messageController.text.trim();

                    if (subject.isEmpty || message.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter subject and message"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    debugPrint("Sending campaign to $recipients users...");
                    debugPrint("Subject: $subject");
                    debugPrint("Message: $message");
                  },
                  text: "Send Campaign",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
