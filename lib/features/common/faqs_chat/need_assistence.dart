import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/config/constants/strings.dart';
import 'package:tasti_restaurant_app/core/services/launcher_services.dart';
import 'package:tasti_restaurant_app/features/common/faqs_chat/chat_screen.dart';
import '/config/constants/colors.dart';
import '/core/widgets/custom_button.dart';

class NeedFurtherAssistence extends StatelessWidget {
  NeedFurtherAssistence({super.key});

  final String phoneNumber = AppConstants.phoneNumber;

  void _showContactOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Call'),
                onTap: (){
                  UrlLauncherService().callPhoneNumber(phoneNumber);
                },
              ),
              ListTile(
                leading: const Icon(Icons.chat),
                title: const Text('WhatsApp'),
                onTap: () async {
                  UrlLauncherService().sendWhatsAppMessage(phoneNumber, '');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Need Further Assistance?'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.support_agent,
              size: 120,
              color: AppColors.darkOrange,
            ),
            const SizedBox(height: 24),
            const Text(
              'We are here to help you!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            CustomButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChatBotScreen()),
                );
              },
              text: "Intercom chat support",
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: () => _showContactOptions(context),
              text: 'Contact via Phone/WhatsApp',
            ),
          ],
        ),
      ),
    );
  }
}
