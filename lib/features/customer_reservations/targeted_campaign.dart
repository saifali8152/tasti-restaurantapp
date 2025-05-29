import 'package:flutter/material.dart';
import '/config/routes/route_name.dart';
import '../make_reservation/make_reservation.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/custom_dropdown.dart';
import '/core/widgets/custom_input_field.dart';

class TargetedCampaign extends StatefulWidget {
  const TargetedCampaign({super.key});

  @override
  State<TargetedCampaign> createState() => _TargetedCampaignState();
}

class _TargetedCampaignState extends State<TargetedCampaign> {
  final _formKey = GlobalKey<FormState>();

  String? selectedRecipients;
  String? selectedMinAge;
  String? selectedMaxAge;
  String? selectedGender;
  String? selectedMessageType;
  String? selectedProvince;

  final List<String> recipientOptions = ['10', '50', '100', '500', '1000+'];
  final List<String> ageOptions = List.generate(83, (i) => (i + 18).toString());
  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  final List<String> messageTypes = [];
  final List<String> provinces = ['Province A', 'Province B', 'Province C'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Targeted Campaign'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Estimated Cost: ", style: TextStyle(fontSize:18)),
                  Text("R 0.00", style: TextStyle(fontSize:18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 20),
              FieldLabel(title: "Number of Recipients"),
              const SizedBox(height: 5),
              CustomDropdown(
                items: recipientOptions
                    .map((val) => DropdownMenuEntry(value: val, label: val))
                    .toList(),
                onChanged: (val) => setState(() => selectedRecipients = val),
                hintText: 'Select',
              ),

              const SizedBox(height: 10),
              FieldLabel(title: "Minimum Age"),
              const SizedBox(height: 5),
              CustomDropdown(
                items: ageOptions
                    .map((val) => DropdownMenuEntry(value: val, label: val))
                    .toList(),
                onChanged: (val) => setState(() => selectedMinAge = val),
                hintText: 'Select',
              ),

              const SizedBox(height: 10),
              FieldLabel(title: "Maximum Age"),
              const SizedBox(height: 5),
              CustomDropdown(
                items: ageOptions
                    .map((val) => DropdownMenuEntry(value: val, label: val))
                    .toList(),
                onChanged: (val) => setState(() => selectedMaxAge = val),
                hintText: 'Select',
              ),

              const SizedBox(height: 10),
              FieldLabel(title: "Gender"),
              const SizedBox(height: 5),
              CustomDropdown(
                items: genderOptions
                    .map((val) => DropdownMenuEntry(value: val, label: val))
                    .toList(),
                onChanged: (val) => setState(() => selectedGender = val),
                hintText: 'Select',
              ),

              const SizedBox(height: 20),
              FieldLabel(title: "Message Type"),
              const SizedBox(height: 5),
              CustomDropdown(
                items: messageTypes
                    .map((val) => DropdownMenuEntry(value: val, label: val))
                    .toList(),
                onChanged: (val) => setState(() => selectedMessageType = val),
                hintText: 'Select',
              ),

              const SizedBox(height: 20),
              FieldLabel(title: "Province"),
              const SizedBox(height: 5),
              CustomDropdown(
                items: provinces
                    .map((val) => DropdownMenuEntry(value: val, label: val))
                    .toList(),
                onChanged: (val) => setState(() => selectedProvince = val),
                hintText: 'Select',
              ),

              const SizedBox(height: 20),
              FieldLabel(title: "City"),
              const CustomInputField(hintText: "Enter city name"),

              const SizedBox(height: 20),
              FieldLabel(title: "Message Content"),
              const CustomInputField(
                contentPadding: EdgeInsets.all(20),
                maxLines: 5,
              ),

              const SizedBox(height: 30),
              CustomButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.campaignSummary);
                },
                text: 'Send Campaign',
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}

