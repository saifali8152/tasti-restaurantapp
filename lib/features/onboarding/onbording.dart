import 'package:flutter/material.dart';
import '../../config/routes/route_name.dart';
import 'onbording_page2.dart';
import 'onbording_page3.dart';
import '../../config/constants/colors.dart';
import 'onbording_page.dart';
import '../../config/constants/icons.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final PageController _controller = PageController();

  final List<Widget> pages = [
    OnboardingPage(),
    OnboardingPage2(),
    OnboardingPage3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.darkOrange,
            AppColors.darkGrey,
            AppColors.darkGrey,
            AppColors.darkGrey,
            AppColors.darkOrange
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return pages[index];
              },
            ),
            Positioned(
              bottom: 30,
              left: 30,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RoutesName.login, (route) => false);
                },
                child: Text(
                  "SKIP",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              right: 30,
              child: GestureDetector(
                onTap: () {
                  if (_controller.page == pages.length - 1) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RoutesName.signup, (route) => false);
                  } else {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: AppColors.darkOrange,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    AppIcons.arrowForward,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
