import 'package:flutter/material.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBGColor,
    required this.title,
    required this.subTitle,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBGColor;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // توسيط المحتوى عمودياً
      children: [
        const Spacer(flex: 2), // مساحة مرنة علوية
        
        // الحاوية الخاصة بالأيقونة
        Container(
          width: 25.w,
          height: 25.w,
          decoration: BoxDecoration(
            color: iconBGColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: iconColor.withValues(alpha:0.6),
                blurRadius: 15,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(icon, color: iconColor, size: 40), // حجم ثابت للأيقونة لضمان الظهور
        ),
        
        const Spacer(flex: 1), // مسافة مرنة بين الأيقونة والنص

        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20, // حجم خط ثابت للأمان
            fontWeight: FontWeight.bold,
            color: kTextColor,
          ),
        ),
        
        SizedBox(height: 2.h),

        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: kSubTextColor,
          ),
        ),
        
        const Spacer(flex: 3), // مساحة مرنة سفلية
      ],
    );
  }
}