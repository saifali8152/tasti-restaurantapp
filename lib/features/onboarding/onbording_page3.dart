import 'package:flutter/material.dart';
import '../../config/constants/spaces.dart';
import '../../config/constants/images.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 110),
        SizedBox(
          width: double.infinity,
          child: Image.asset(
            AppImages.onboarding3,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpaces.screenHpad),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 34, color: Colors.white),
              children: [
                TextSpan(text: "Get Ready for an"),
                TextSpan(
                  text: " Unforgettable",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: " Dining & Nightlife Experience"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
