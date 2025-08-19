import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_app_bar.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_button.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_input_field.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/resevation_data.dart';

class SentCampaignArguments {
  final List<ReservationDataEntity> data;
  final String response;

  SentCampaignArguments(this.data, this.response);
}

class SentCampaign extends StatefulWidget {
  final SentCampaignArguments arguments;
  const SentCampaign({super.key, required this.arguments});

  @override
  State<SentCampaign> createState() => _SentCampaignState();
}

class _SentCampaignState extends State<SentCampaign> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final recipients = widget.arguments.data;
    final smsBalance = widget.arguments.response;

    final int totalRecipients = recipients.length;
    final int emailRecipients = recipients
        .where((r) =>
            r.customerEmail != null &&
            r.customerEmail!.isNotEmpty &&
            r.customerEmail != "No email")
        .length;
    final int smsRecipients = recipients
        .where(
            (r) => r.customerPhone.isNotEmpty && r.customerPhone != "No phone")
        .length;

    return Scaffold(
      appBar: const CustomAppBar(title: "Campaign Manager"),
      body: SingleChildScrollView(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatItem(
                    icon: Icons.people,
                    label: "Total Recipients",
                    value: totalRecipients.toString(),
                  ),
                  _buildStatItem(
                    icon: Icons.email,
                    label: "Email Recipients",
                    value: emailRecipients.toString(),
                  ),
                  _buildStatItem(
                    icon: Icons.sms,
                    label: "SMS Recipients",
                    value: smsRecipients.toString(),
                  ),
                  _buildStatItem(
                    icon: Icons.sms_outlined,
                    label: "SMS Balance",
                    value: smsBalance,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Inside your build method (replace the current Recipients Preview part)
            ExpansionTile(
              tilePadding: EdgeInsets.all(0),
              initiallyExpanded: false,
              leading: const Icon(Icons.list),
              title: const Text(
                "Recipients Preview",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recipients.length,
                  itemBuilder: (context, index) {
                    final recipient = recipients[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 8),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(
                          recipient.customerName,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (recipient.customerEmail != null &&
                                recipient.customerEmail!.isNotEmpty &&
                                recipient.customerEmail != "No email")
                              Text("📧 ${recipient.customerEmail}"),
                            if (recipient.customerPhone.isNotEmpty &&
                                recipient.customerPhone != "No phone")
                              Text("📱 ${recipient.customerPhone}"),
                          ],
                        ),
                        trailing: _buildTypeChip(recipient.type),
                      ),
                    );
                  },
                ),
              ],
            ),

            // Campaign Subject
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.subject),
                const SizedBox(width: 8),
                const Text(
                  "Campaign Subject",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            CustomInputField(
              controller: _subjectController,
              hintText: "Enter campaign subject/title",
            ),
            const SizedBox(height: 20),
            // Message Content
            Row(
              children: [
                const Icon(Icons.message),
                const SizedBox(width: 8),
                const Text(
                  "Message Content",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            CustomInputField(
              controller: _messageController,
              maxLines: 5,
              hintText: "Type your campaign message here...",
            ),
            // Bottom text
            Center(
              child: Text(
                "This message will be sent via both SMS ($smsRecipients recipients) and Email ($emailRecipients recipients).",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
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

                    debugPrint("Sending campaign to $totalRecipients users...");
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

  Widget _buildStatItem(
      {required IconData icon, required String label, required String value}) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.teal),
            const SizedBox(width: 6),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ],
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildTypeChip(String type) {
    Color color;
    switch (type) {
      case "Manual":
        color = Colors.orange.shade200;
        break;
      case "Registered":
        color = Colors.green.shade200;
        break;
      default:
        color = Colors.grey.shade200;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        type,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}
