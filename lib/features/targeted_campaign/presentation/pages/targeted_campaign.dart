import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/core/utils/flushbar_extention.dart';
import 'package:tasti_restaurant_app/core/widgets/field_label.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/targeted_campaign/presentation/bloc/targeted_campaign_bloc.dart';
import 'package:tasti_restaurant_app/features/targeted_campaign/presentation/bloc/targeted_campaign_event.dart';
import 'package:tasti_restaurant_app/features/targeted_campaign/presentation/bloc/targeted_campaign_state.dart';
import '/config/routes/route_name.dart';
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
  AddTargetedCampaignParms? campaignData;

  final TextEditingController recipientsController = TextEditingController();
  String? selectedMinAge;
  String? selectedMaxAge;
  String? selectedGender;
  String? selectedMessageType;
  String? selectedProvince;
  final TextEditingController cityController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TargetedCampaignBloc bloc = sl();
  final int id = SessionController().user?.restaurant.id ?? 0;
  double estimatedCost = 0;

  final List<String> ageOptions =
      List.generate(103, (i) => (i + 18).toString()); // 18 to 120
  final List<Map<String, String>> genderOptions = [
    {'label': 'All', 'value': 'all'},
    {'label': 'Male', 'value': 'male'},
    {'label': 'Female', 'value': 'female'},
  ];
  final List<Map<String, String>> messageTypes = [
    {'label': 'SMS Only', 'value': 'sms'},
    {'label': 'Email Only', 'value': 'email'},
    {'label': 'Both SMS & Email', 'value': 'both'},
  ];
  final List<String> provinces = [
    'Gauteng',
    'Free State',
    'Eastern Cape',
    'Western Cape',
    'Kwazulu-Natal',
    'Limpopo',
    'Mpumalanga',
    'North West',
    'Northern Cape',
  ];

  // Calculate estimated cost
  void updateCost() {
    final recipients = int.tryParse(recipientsController.text) ?? 0;
    double rate = 0;
    if (selectedMessageType == 'sms') rate = 0.7;
    if (selectedMessageType == 'email') rate = 0.1;
    if (selectedMessageType == 'both') rate = 0.8;
    setState(() {
      estimatedCost = recipients * rate;
    });
  }

  @override
  void initState() {
    super.initState();
    // Update cost whenever recipients input changes
    recipientsController.addListener(updateCost);
  }

  @override
  void dispose() {
    recipientsController.removeListener(updateCost);
    recipientsController.dispose();
    cityController.dispose();
    messageController.dispose();
    super.dispose();
  }

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
              // Estimated Cost
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Estimated Cost: ",
                      style: TextStyle(fontSize: 18)),
                  Flexible(
                    child: Text(
                      "R ${estimatedCost.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Number of Recipients
              FieldLabel(title: "Number of Recipients"),
              const SizedBox(height: 5),
              CustomInputField(
                controller: recipientsController,
                hintText: "Enter number of recipients",
                keyboardInputType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Required";
                  if (int.tryParse(val) == null || int.parse(val) < 100) {
                    return "Minimum 100 recipients";
                  }
                  return null;
                },
                onChanged: (value) {
                  updateCost();
                },
              ),

              const SizedBox(height: 10),
              // Minimum Age
              FieldLabel(title: "Minimum Age"),
              const SizedBox(height: 5),
              CustomInputField(
                controller: TextEditingController(text: selectedMinAge),
                hintText: "Enter minimum age",
                keyboardInputType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Required";
                  final age = int.tryParse(val);
                  if (age == null || age < 18 || age > 120) {
                    return "Age must be between 18 and 120";
                  }
                  return null;
                },
                onChanged: (val) => selectedMinAge = val,
              ),

              const SizedBox(height: 10),
              FieldLabel(title: "Maximum Age"),
              const SizedBox(height: 5),
              CustomInputField(
                controller: TextEditingController(text: selectedMaxAge),
                hintText: "Enter maximum age",
                keyboardInputType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Required";
                  final age = int.tryParse(val);
                  if (age == null || age < 18 || age > 120) {
                    return "Age must be between 18 and 120";
                  }
                  if (selectedMinAge != null &&
                      int.tryParse(selectedMinAge!) != null &&
                      int.parse(val) < int.parse(selectedMinAge!)) {
                    return "Maximum age cannot be less than minimum age";
                  }
                  return null;
                },
                onChanged: (val) => selectedMaxAge = val,
              ),

              const SizedBox(height: 10),
              // Gender
              FieldLabel(title: "Gender"),
              const SizedBox(height: 5),
              CustomDropdown(
                items: genderOptions
                    .map((g) => DropdownMenuEntry(
                          value: g['value']!,
                          label: g['label']!,
                        ))
                    .toList(),
                onChanged: (val) => setState(() => selectedGender = val),
                hintText: 'Select',
              ),

              const SizedBox(height: 20),
              // Message Type
              FieldLabel(title: "Message Type"),
              const SizedBox(height: 5),
              CustomDropdown(
                items: messageTypes
                    .map((m) => DropdownMenuEntry(
                        value: m['value']!, label: m['label']!))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedMessageType = val;
                  });
                  updateCost();
                },
                hintText: 'Select',
              ),

              const SizedBox(height: 20),
              // Province
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
              // City
              FieldLabel(title: "City"),
              CustomInputField(
                controller: cityController,
                hintText: "Enter city name",
              ),

              const SizedBox(height: 20),
              // Message Content
              FieldLabel(title: "Message Content"),
              CustomInputField(
                controller: messageController,
                contentPadding: const EdgeInsets.all(20),
                maxLines: 5,
              ),

              const SizedBox(height: 30),
              BlocConsumer<TargetedCampaignBloc, TargetedCampaignState>(
                bloc: bloc,
                listener: (context, state) {
                  if (state.addResponse.status == Status.error) {
                    context.flushBarErrorMessage(
                        message: state.addResponse.message.toString());
                  }
                  if (state.addResponse.status == Status.completed) {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.campaignSummary,
                      arguments: campaignData,
                    );
                    context.flushBarSuccessMessage(message: state.addResponse.data?.message.toString() ??'');
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    isLoading: state.addResponse.status == Status.loading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        campaignData = AddTargetedCampaignParms(
                          restaurantId: id.toString(),
                          people: int.parse(recipientsController.text),
                          minAge: int.parse(selectedMinAge ?? "18"),
                          maxAge: int.parse(selectedMaxAge ?? "120"),
                          gender: selectedGender ?? "all",
                          smsTo: selectedMessageType ?? "sms",
                          province: selectedProvince ?? "",
                          city: cityController.text,
                          campaignMessage: messageController.text,
                          cost: estimatedCost,
                          tempId: state.addResponse.data?.tempId ?? ''
                        );
                        bloc.add(AddTargetedCampaignEvent(campaignData!));
                      }
                    },
                    text: 'Send Campaign',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
