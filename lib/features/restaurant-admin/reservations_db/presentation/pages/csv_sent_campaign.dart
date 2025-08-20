import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/config/routes/route_name.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/services/session_controller.dart';
import '/core/utils/flushbar_extention.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/custom_input_field.dart';
import '/features/restaurant-admin/reservations_db/domain/entities/csv_data.dart';
import '/features/restaurant-admin/reservations_db/presentation/bloc/customer_reservations/customer_reservations_bloc.dart';
import '/features/restaurant-admin/reservations_db/presentation/bloc/customer_reservations/customer_reservations_event.dart';
import '/features/restaurant-admin/reservations_db/presentation/bloc/customer_reservations/customer_reservations_state.dart';

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
  final int id = SessionController().user?.restaurant.id ?? 0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final recipients = widget.arguments.data.length;
    final smsBalance = widget.arguments.response;

    return Scaffold(
      appBar: CustomAppBar(title: "Campaign Manager"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form( // ✅ Wrap everything inside a Form
            key: _formKey,
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Subject is required";
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Message is required";
                    }
                    return null;
                  },
                ),
          
                const SizedBox(height: 20),
          
                // Send button
                BlocConsumer<CustomerReservationsBloc, CustomerReservationsState>(
                  bloc: context.read<CustomerReservationsBloc>(),
                  listener: (context, state) {
                    if (state.sendCSVResponse.status == Status.error) {
                      context.flushBarErrorMessage(
                          message: state.sendCSVResponse.message.toString());
                    }
                    if (state.sendCSVResponse.status == Status.completed) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.skaleton, (route) => false);
                      context.flushBarSuccessMessage(
                          message: state.sendCSVResponse.data.toString());
                    }
                  },
                  builder: (context, state) {
                    return Hero(
                      tag: "Send SMS/Email",
                      child: Material(
                        type: MaterialType.transparency,
                        child: CustomButton(
                          isLoading:
                              state.sendCSVResponse.status == Status.loading,
                          onPressed: () {
                            // ✅ Validate form before sending
                            if (_formKey.currentState?.validate() ?? false) {
                              final subject = _subjectController.text.trim();
                              final message = _messageController.text.trim();

                              context.read<CustomerReservationsBloc>().add(
                                    SendCSVData(
                                      SendCSVDataParams(
                                        restaurantId: id,
                                        subject: subject,
                                        message: message,
                                        selectedIds: widget.arguments.data
                                            .map((e) => e.id.toString())
                                            .toList(),
                                      ),
                                    ),
                                  );

                              debugPrint(
                                  "Sending campaign to $recipients users...");
                              debugPrint("Subject: $subject");
                              debugPrint("Message: $message");
                            }
                          },
                          text: "Send Campaign",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
