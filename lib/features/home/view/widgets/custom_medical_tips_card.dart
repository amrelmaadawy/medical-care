import 'package:flutter/material.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';

class CustomMedicalTipsCard extends StatelessWidget {
  const CustomMedicalTipsCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
  });
  final IconData icon;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefBorderRadius),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              width: 17.w,
              height: 17.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kDefBorderRadius - 5),
                color: kHghtLightBlueColor,
              ),
              child: Icon(icon, color: kPrimryColor, size: 7.sp),
            ),
            SizedBox(width: 3.w),
            SizedBox(
              width: 60.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 1.h),

                  Text(
                    title,
                    style: TextStyle(color: kTextColor, fontSize: 4.sp),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    subTitle,
                    style: TextStyle(color: kSubTextColor, fontSize: 3.6.sp),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
