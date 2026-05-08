import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/features/onboarding/onboarding_view.dart';
import 'package:medical_care/core/services/notification_service.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // 1. Await heavy initializations that might freeze some physical devices
    try {
      await NotificationService.instance.init();
      await NotificationService.instance.requestPermissions();
    } catch (e) {
      debugPrint('Error during initialization: $e');
    }

    // 2. Add an artificial delay so splash is visible for at least 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    // 3. Navigate securely
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingView()),
      );
    }
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
            Image.asset(
              'assets/images/Simple Medical Health Logo.png',
              width: 240,
              height: 240,
            ),
            SizedBox(height: 2.h),

            // App Name
            Text(
              'الرعاية الطبية',
              style: TextStyle(
                fontSize: 28, // Large font size
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                color: kTextColor,
                fontFamily: 'Cairo',
              ),
            ),

            SizedBox(height: 5.h),

            // Loading Indicator
            SpinKitThreeBounce(color: kTextColor, size: 30),
          ],
        ),
      ),
    );
  }
}
