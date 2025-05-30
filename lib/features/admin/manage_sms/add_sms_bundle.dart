import 'package:flutter/material.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/custom_input_field.dart';

class AddSMSBundle extends StatefulWidget {
  const AddSMSBundle({super.key});

  @override
  State<AddSMSBundle> createState() => _AddSMSBundleState();
}

class _AddSMSBundleState extends State<AddSMSBundle> {
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Add SMS Bundle'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              FieldLabel(title: "Product Owner"),
              CustomInputField(
                hintText: 'Enter owner name',
              ),
              SizedBox(height: 10),
              FieldLabel(title: "Discount"),
              CustomInputField(
                hintText: '',
              ),
              SizedBox(height: 10),
              FieldLabel(title: "SMS Quantity"),
              CustomInputField(
                hintText: 'Enter SMS quantity',
              ),
              SizedBox(height: 10),
              FieldLabel(title: "Discount Percentage"),
              CustomInputField(
                hintText: 'Enter discount percentage',
                keyboardInputType: TextInputType.number,
              ),
              SizedBox(height: 10),
              FieldLabel(title: "Price"),
              CustomInputField(
                hintText: 'Enter price',
                keyboardInputType: TextInputType.number,
              ),
              const SizedBox(height: 30),
              CustomButton(
                onPressed: () {},
                text: 'Add SMS Bundle',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FieldLabel extends StatelessWidget {
  final String title;
  const FieldLabel({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(fontWeight: FontWeight.bold));
  }
}
