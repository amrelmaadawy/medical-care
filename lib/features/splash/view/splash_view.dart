import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/features/onboarding/onboarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // Navigate to OnboardingView after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Initialize SizeConfig to ensure responsiveness
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo (Using Icon as fallback since no asset image was found)
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimryColor.withOpacity(0.1),
              ),
              child: Icon(
                Icons.health_and_safety,
                size: 80, // Large size for logo
                color: kPrimryColor,
              ),
            ),
            SizedBox(height: 2.h),

            // App Name
            Text(
              'الرعاية الطبية',
              style: TextStyle(
                fontSize: 24, // Large font size
                fontWeight: FontWeight.bold,
                color: kPrimryColor,
                fontFamily: 'Cairo',
              ),
            ),

            SizedBox(height: 10.h),

            // Loading Indicator
            CircularProgressIndicator(color: kPrimryColor),
          ],
        ),
      ),
    );
  }
}
