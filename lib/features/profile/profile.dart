import 'package:flutter/material.dart';
import '../../config/constants/colors.dart';
import '../../config/constants/icons.dart';
import '../../config/routes/route_name.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_tile.dart';
import '../../core/services/session_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!SessionController().isLogin) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Get Started!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              CustomButton(onPressed: () {}, text: "Sign up or Login"),
            ],
            if (SessionController().isLogin) ...[
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade300,
                  child: Text(
                    "M",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  "Muhammad Umar",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "About You",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              CustomTile(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Image.asset(AppIcons.profile,
                      height: 20, color: AppColors.black),
                ),
                title: "Personal Information",
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.personalInfo,
                  );
                },
              ),
              CustomTile(
                leading: Icon(Icons.settings_outlined),
                title: "Settings",
                onTap: () {},
              ),
            ],
            SizedBox(height: 20),
            Text(
              "Bookings",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            CustomTile(
              leading: Icon(Icons.menu_book_outlined),
              title: "Bookings",
              onTap: () {},
            ),
            Text(
              "Help Center",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            CustomTile(
              leading: Icon(Icons.help_outline_outlined),
              title: "Contact Us",
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.contactUs);
              },
            ),
            CustomTile(
              leading: Icon(Icons.description_outlined),
              title: "Get Support",
            ),
            CustomButton(
              onPressed: () {},
              text: "Logout",
              isFullWidth: false,
              bgColor: Colors.white,
              textColor: Colors.red,
              borderColor: Colors.transparent,
            ),
            Spacer(),
            SessionController().isLogin
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      CustomButton(
                        onPressed: () {},
                        text: "Delete Account",
                        isFullWidth: false,
                        bgColor: Colors.white,
                        textColor: Colors.red,
                        borderColor: Colors.transparent,
                      ),
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
