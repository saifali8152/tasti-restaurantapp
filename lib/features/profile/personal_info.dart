import 'package:flutter/material.dart';
import '../../config/constants/spaces.dart';
import '../../config/routes/route_name.dart';
import '../../core/widgets/custom_input_field.dart';
import '../../core/widgets/custom_tile.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpaces.screenHpad),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade300,
              child: Text(
                "M",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Muhammad Umar",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            CustomInputField(
              hintText: "First Name",
              icon: Icons.person,
            ),
            CustomInputField(
              hintText: "Email",
              icon: Icons.email,
            ),
            CustomInputField(
              hintText: "Phone Number",
              icon: Icons.phone,
            ),
            SizedBox(height: 20),
            CustomTile(
              leading: Icon(Icons.lock_outline),
              title: "Change Password",
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.forgotPassword );
              },
        
            )
          ],
        ),
      ),
    );
  }
}
