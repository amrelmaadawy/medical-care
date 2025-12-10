import 'package:flutter/material.dart';
import 'package:medical_care/core/components/custom_elevated_button.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';

class DiagnosisItem extends StatelessWidget {
  const DiagnosisItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                      style: TextStyle(fontSize: 3.5.sp, color: kGreenColor),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              '٢٨ نوفمبر ٢٠٢٥ - ٠٩:٣٠ صباحاً',
              style: TextStyle(fontSize: 3.5.sp, color: kSubTextColor),
            ),
            SizedBox(height: 1.h),
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
            SizedBox(height: 4.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomElevatedButton(
                  widget: Icon(
                    Icons.visibility_outlined,
                    color: kPrimryColor,
                    size: 5.5.sp,
                  ),
                  text: 'عرض',
                  borderColor: kPrimryColor,
                  textColor: kPrimryColor,
                  width: 30.w,
                  onPressed: () {},
                ),
                CustomElevatedButton(
                  widget: Icon(
                    Icons.download_outlined,
                    color: kTextColor,
                    size: 5.5.sp,
                  ),
                  text: 'تنزيل',
                  borderColor: kgreyHighlightColor,
                  textColor: kTextColor,
                  width: 30.w,
                  onPressed: () {},
                ),
                CustomElevatedButton(
                  widget: Icon(
                    Icons.delete_outline_outlined,
                    color: kRedColor,
                    size: 5.sp,
                  ),
                  text: '',
                  borderColor: kHghtLightRedColor,
                  textColor: kRedColor,
                  width: 18.w,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
