import 'package:flutter/material.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 6.sp,
          backgroundColor: kPrimryColor,
          child: Icon(
            Icons.health_and_safety_outlined,
            color: Colors.white,
            size: 7.sp,
          ),
        ),
        SizedBox(width: 3.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مرحبا ',
              style: TextStyle(
                color: kSubTextColor,
                fontSize: 4.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'احمد محمد',
              style: TextStyle(
                fontSize: 4.sp,
                color: kTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Spacer(),
        // CircleAvatar(
        //   backgroundColor: kgreyHighlightColor,
        //   radius: 6.sp,
        //   child: IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.notifications_active_outlined,
        //       color: kSubTextColor,
        //       size: 7.sp,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
