import 'package:flutter/material.dart';
import 'package:medical_care/core/components/custom_elevated_button.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/features/history/model/assessments/assessment.dart';
import 'package:medical_care/features/history/view/report_view.dart';
import 'package:medical_care/features/history/view/utils/pdf_generator.dart';

class DiagnosisItem extends StatelessWidget {
  final Assessment assessment;
  final VoidCallback onDelete;

  const DiagnosisItem({
    super.key,
    required this.assessment,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    bool isHighRisk = (assessment.riskPercentage ?? 0) > 50;

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    assessment.reason ?? 'غير محدد',
                    style: TextStyle(color: kTextColor, fontSize: 4.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: isHighRisk
                        ? kHghtLightRedColor
                        : kHghtLightGreenColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Text(
                      isHighRisk ? 'مرتفع' : 'منخفض',
                      style: TextStyle(
                        fontSize: 3.5.sp,
                        color: isHighRisk ? kRedColor : kGreenColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Text(
              assessment.createdAt ?? '',
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
                  '${assessment.riskPercentage}%',
                  style: TextStyle(
                    color: isHighRisk ? kRedColor : kGreenColor,
                    fontSize: 4.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
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
                  width: 28.w,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ReportView(assessment: assessment),
                      ),
                    );
                  },
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
                  width: 28.w,
                  onPressed: () {
                    PdfGenerator.generateAndPrint(assessment);
                  },
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
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
