import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';

class StartDiagnosis extends StatelessWidget {
  const StartDiagnosis({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefBorderRadius),
      ),
      width: double.infinity,
      height: 33.h,
      child: DottedBorder(
        options: RectDottedBorderOptions(
          color: kPrimryColor,
          dashPattern: [5, 3],
          strokeWidth: 1.5,
          padding: EdgeInsets.all(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 8.sp,
                  backgroundColor: kHghtLightBlueColor,
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: kPrimryColor,
                    size: 8.sp,
                  ),
                ),
                Text(
                  'تحميل صوره للتشخيص ',
                  style: TextStyle(color: kTextColor, fontSize: 4.5.sp),
                ),
                Text(
                  'قم بتحميل صورة طبيه للحصول علي تشخيص دقيق',
                  style: TextStyle(color: kSubTextColor, fontSize: 3.5.sp),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 5.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(
                          kDefBorderRadius,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'ابدا التشخيص ',
                      style: TextStyle(color: Colors.white, fontSize: 3.5.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
