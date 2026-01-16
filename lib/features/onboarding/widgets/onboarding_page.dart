import 'package:flutter/material.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';

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
    return Padding(
      padding: const EdgeInsets.all(kDefPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.h),
          Container(
            width: 25.w,
            height: 25.w,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: iconColor.withValues(alpha: 0.7),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              color: iconBGColor,
              borderRadius: BorderRadius.circular(kDefBorderRadius),
            ),
            child: Icon(icon, color: iconColor, size: 15.sp),
          ),
          SizedBox(height: 2.h),

          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 6.sp,
              fontWeight: FontWeight.w600,
              color: kTextColor,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 4.sp,
              fontWeight: FontWeight.w600,
              color: kSubTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
