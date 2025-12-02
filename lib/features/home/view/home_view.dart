import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';
import 'package:medical_care/features/home/view/widgets/custom_medical_tips_card.dart';

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
            Row(
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
                      style: TextStyle(color: kSubTextColor, fontSize: 3.8.sp),
                    ),
                    Text(
                      'احمد محمد',
                      style: TextStyle(fontSize: 3.8.sp, color: kTextColor),
                    ),
                  ],
                ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: kgreyHighlightColor,
                  radius: 6.sp,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_active_outlined,
                      color: kSubTextColor,
                      size: 7.sp,
                    ),
                  ),
                ),
              ],
            ),
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
            Container(
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
                          style: TextStyle(
                            color: kSubTextColor,
                            fontSize: 3.5.sp,
                          ),
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
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 3.5.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'نصائح طبيه',
              style: TextStyle(color: kTextColor, fontSize: 4.sp),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CustomMedicalTipsCard(
                    icon: FontAwesomeIcons.pills,
                    title: 'الأدوية',
                    subTitle: 'التزم بمواعيد الأدوية المحددة',
                  ),
                  CustomMedicalTipsCard(
                    icon: FontAwesomeIcons.stethoscope,
                    title: 'الفحص الدوري',
                    subTitle: ' قم بالفحص الطبي كل 6 أشهر',
                  ),
                  CustomMedicalTipsCard(
                    icon: FontAwesomeIcons.heart,
                    title: 'شرب الماء',
                    subTitle: 'احرص على شرب 8 أكواب ماء يومياً',
                  ),
                ],
              ),
            ),
            Text(
              'آخر عملية تشخيص',
              style: TextStyle(fontSize: 4.sp, color: kTextColor),
            ),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'تشخيص الأشعة السينية للصدر',
                          style: TextStyle(color: kTextColor, fontSize: 4.sp),
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kHghtLightGreenColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'منخفض',
                              style: TextStyle(
                                fontSize: 3.5.sp,
                                color: kGreenColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '٢٨ نوفمبر ٢٠٢٥ - ٠٩:٣٠ صباحاً',
                      style: TextStyle(fontSize: 3.5.sp, color: kSubTextColor),
                    ),
                    SizedBox(height: 1.h,),
                    Row(
                      children: [
                        Text(
                          'مستوى الخطورة ',
                          style: TextStyle(fontSize: 4.sp, color: kTextColor),
                        ),
                        Text(
                          '15%',
                          style: TextStyle(color: kGreenColor, fontSize: 4.sp),
                        ),
                      ],
                    ),
                    SizedBox(height:4.sp),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: kPrimryColor),
                        borderRadius: BorderRadius.circular(kDefBorderRadius),
                      ),
                      width: double.infinity,
                      height: 5.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(
                              kDefBorderRadius,
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'عرض التفاصيل',
                          style: TextStyle(
                            color: kPrimryColor,
                            fontSize: 3.5.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
