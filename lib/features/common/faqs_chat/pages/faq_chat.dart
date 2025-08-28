import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/config/constants/faqs.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_button.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_expantion_tile.dart';
import 'package:tasti_restaurant_app/features/common/faqs_chat/pages/need_assistence.dart';

class FAQChatScreen extends StatelessWidget {
  const FAQChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQs"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...faqs.map((faq) => CustomExpansionTile(
                title: faq["question"]!,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(faq["answer"]!),
                  ),
                ],
              )),
          const SizedBox(height: 24),
          CustomButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NeedFurtherAssistence()),
              );
            },
            text: "Need further assistence",
          )
        ],
      ),
    );
  }
}
