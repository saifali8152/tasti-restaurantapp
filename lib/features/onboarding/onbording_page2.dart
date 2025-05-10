import 'package:flutter/material.dart';
import '../../config/constants/spaces.dart';
import '../../config/constants/images.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 110),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpaces.screenHpad),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 34, color: Colors.white),
              children: [
                TextSpan(text: "Book a"),
                TextSpan(
                  text: " — Table in Seconds",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: " — No Calls, No Waiting"),
              ],
            ),
          ),
        ),
        const SizedBox(height: 60),
        SizedBox(
          width: double.infinity,
          height: 330,
          child: Stack(
            children: [
              Image.asset(
                AppImages.onboarding2_0,
                fit: BoxFit.cover,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Image.asset(
                  AppImages.onboarding2_1,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
