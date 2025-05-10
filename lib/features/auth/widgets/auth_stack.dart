import 'package:flutter/material.dart';
import '../../../config/constants/images.dart';

class AuthStack extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  const AuthStack({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  AppImages.authBg,
                  fit: BoxFit.cover,
                ),
                Container(
                  color:
                      Colors.black54,
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.logo),
                  SizedBox(width: 5),
                  Image.asset(AppImages.testi),
                ],
              ),
              SizedBox(height: 50),
      
              // Welcome Text
              Text(
                title,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
      
              child,
            ],
          ),
        ],
      ),
    );
  }
}
