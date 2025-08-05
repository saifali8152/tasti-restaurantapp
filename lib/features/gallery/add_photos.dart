import 'package:flutter/material.dart';
import '../../core/widgets/custom_button.dart';
import '/core/widgets/custom_app_bar.dart';

class AddPhotosScreen extends StatelessWidget {
  const AddPhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Photos',
      ),
      backgroundColor: Colors.grey.shade50,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Choose Image", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            // const CustomUploadImageCard(),
            const SizedBox(height: 20),
            CustomButton(onPressed: () {}, text: "Upload"),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
