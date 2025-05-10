import 'package:flutter/material.dart';
import '../../config/constants/images.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 60),
        SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                AppImages.onboarding1,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 34, color: Colors.white),
              children: [
                TextSpan(
                  text: "Discover",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: " the Best\nRestaurants, Bars & Nightclubs"),
                TextSpan(
                  text: " Near You",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
