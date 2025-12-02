import 'package:flutter/material.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';
import 'package:medical_care/features/home/view/widgets/custom_home_app_bar.dart';
import 'package:medical_care/features/home/view/widgets/last_diagnosis_operation.dart';
import 'package:medical_care/features/home/view/widgets/medical_tips.dart';
import 'package:medical_care/features/home/view/widgets/start_diagnosis.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefPadding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHomeAppBar(),
            SizedBox(height: 3.h),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPrimryColor,
                borderRadius: BorderRadius.circular(kDefBorderRadius),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'اجمالي التشخيصات',
                          style: TextStyle(
                            color: Color(0XFFeaf1f9),
                            fontSize: 4.5.sp,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          '24',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 6.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 7.sp,
                      backgroundColor: kLightBlueColor,
                      child: Icon(
                        Icons.health_and_safety_outlined,
                        color: Colors.white,
                        size: 8.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 3.h),
            StartDiagnosis(),
            SizedBox(height: 3.h),
            Text(
              'نصائح طبيه',
              style: TextStyle(color: kTextColor, fontSize: 4.sp),
            ),

            MedicalTips(),
            Text(
              'آخر عملية تشخيص',
              style: TextStyle(fontSize: 4.sp, color: kTextColor),
            ),
            LastDiagnosisOperation(),
          ],
        ),
      ),
    );
  }
}

