import 'package:flutter/material.dart';
import '/config/constants/spaces.dart';
import '/core/widgets/icon_button.dart';
import '/config/constants/colors.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '/config/routes/route_name.dart';
import '../make_reservation/make_reservation.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/custom_input_field.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemedAppBar(
        height: 110,
        title: 'Restaurant Settings',
        subTitle: ButtonWithIcon(
          icon: Icon(Icons.home, color: Colors.white, size: AppSpaces.iconsHeight),
          title: 'Set Vanue Category',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.setVanueCategory);
          },
          bgColor: Color(0xFF0D49AA),
        ),
      ),
      backgroundColor: AppColors.darkOrange,
      body: SingleChildScrollView(
        child: CurvedContainer(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                FieldLabel(title: "Average Cost"),
                const SizedBox(height: 5),
                const CustomInputField(
                  hintText: "Enter average cost",
                ),
                const SizedBox(height: 10),
                FieldLabel(title: "Email"),
                const CustomInputField(
                  hintText: "Enter mail",
                ),
                const SizedBox(height: 10),
                FieldLabel(title: "Address"),
                const CustomInputField(
                  hintText: "Enter address",
                ),
                const SizedBox(height: 10),
                FieldLabel(title: "Website"),
                const CustomInputField(
                  hintText: "Enter website",
                ),
                const SizedBox(height: 10),
                FieldLabel(title: "Phone Number"),
                const CustomInputField(
                  hintText: "Enter phone number",
                ),
                const SizedBox(height: 10),
                FieldLabel(title: "Dress Code"),
                const CustomInputField(
                  hintText: "Enter dress code",
                ),
                const SizedBox(height: 10),
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
      ),
    );
  }
}
