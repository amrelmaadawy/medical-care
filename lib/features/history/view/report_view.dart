import 'package:flutter/material.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/features/history/model/assessments/assessment.dart';
import 'package:medical_care/features/history/view/utils/pdf_generator.dart';

class ReportView extends StatelessWidget {
  final Assessment assessment;

  const ReportView({super.key, required this.assessment});

  @override
  Widget build(BuildContext context) {
    bool isHighRisk = (assessment.riskPercentage ?? 0) > 50;

    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل التقرير'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              PdfGenerator.generateAndPrint(assessment);
            },
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'مستوى الخطورة',
                        style: TextStyle(
                          fontSize: 4.5.sp,
                          fontWeight: FontWeight.bold,
                          color: kTextColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isHighRisk
                              ? kRedColor.withOpacity(0.1)
                              : kGreenColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${assessment.riskPercentage}%',
                          style: TextStyle(
                            fontSize: 5.sp,
                            fontWeight: FontWeight.bold,
                            color: isHighRisk ? kRedColor : kGreenColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 30),
                  _buildInfoRow('تاريخ الفحص', assessment.createdAt ?? '-'),
                  SizedBox(height: 10),
                  _buildInfoRow('رقم السجل', '#${assessment.id}'),
                ],
              ),
            ),

            SizedBox(height: 25),

            Text(
              'التشخيص',
              style: TextStyle(
                fontSize: 5.sp,
                fontWeight: FontWeight.bold,
                color: kPrimryColor,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                assessment.reason ?? 'لا يوجد تشخيص مسجل',
                style: TextStyle(
                  fontSize: 4.sp,
                  color: kTextColor,
                  height: 1.5,
                ),
              ),
            ),

            SizedBox(height: 25),

            Text(
              'الأعراض المسجلة',
              style: TextStyle(
                fontSize: 5.sp,
                fontWeight: FontWeight.bold,
                color: kPrimryColor,
              ),
            ),
            SizedBox(height: 10),
            if (assessment.symptomsSelected != null &&
                assessment.symptomsSelected!.isNotEmpty)
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: assessment.symptomsSelected!
                    .map(
                      (s) => Chip(
                        label: Text(s.name ?? ''),
                        backgroundColor: kPrimryColor.withOpacity(0.05),
                        labelStyle: TextStyle(color: kPrimryColor),
                        side: BorderSide.none,
                      ),
                    )
                    .toList(),
              )
            else
              Text(
                'لا توجد أعراض مسجلة',
                style: TextStyle(color: kSubTextColor),
              ),

            SizedBox(height: 25),

            Text(
              'التوصيات',
              style: TextStyle(
                fontSize: 5.sp,
                fontWeight: FontWeight.bold,
                color: kPrimryColor,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: kPrimryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: kPrimryColor.withOpacity(0.2)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: kPrimryColor),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      assessment.recommendation ??
                          'يرجى متابعة الحالة بانتظام.',
                      style: TextStyle(
                        fontSize: 4.sp,
                        color: kTextColor,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(color: kSubTextColor, fontSize: 3.8.sp),
        ),
        Text(
          value,
          style: TextStyle(
            color: kTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 3.8.sp,
          ),
        ),
      ],
    );
  }
}
