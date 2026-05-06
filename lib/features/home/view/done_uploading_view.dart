import 'package:flutter/material.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';

class DoneUploadingView extends StatelessWidget {
  const DoneUploadingView({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefPadding),
      child: Column(
        children: [
          Container(
            height: 40.h,
            decoration: BoxDecoration(
              color: kHghtLightBlueColor,
              borderRadius: BorderRadius.circular(kDefBorderRadius),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check, color: kPrimryColor, size: 12.sp),
                  Text(
                    'تم رفع الصورة بنجاح',
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 3.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kDefBorderRadius),
              ),
              minimumSize: Size(double.infinity, 7.h),
            ),
            onPressed: () {
              pageController.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: Text(
              ' التالي',
              style: TextStyle(
                fontSize: 5.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
