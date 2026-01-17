import 'package:flutter/material.dart';
import 'package:medical_care/core/components/custom_text_form_field.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';
import 'package:medical_care/features/history/view/widgets/diagnosis_item.dart';
import 'package:medical_care/features/history/model/assessments/assessment.dart';
import 'package:medical_care/features/history/model/assessments/symptoms_selected.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  TextEditingController searchController = TextEditingController();
  List<Assessment> filteredAssessments = [];

  // Mock Data
  List<Assessment> assessments = [
    Assessment(
      id: 101,
      reason: 'تشخيص الأشعة السينية للصدر',
      createdAt: '2025-11-28 09:30:00',
      riskPercentage: 15,
      recommendation: 'الحالة مستقرة، يرجى المتابعة الدورية.',
      symptomsSelected: [
        SymptomsSelected(name: 'سعال خفيف'),
        SymptomsSelected(name: 'الإرهاق'),
      ],
    ),
    Assessment(
      id: 102,
      reason: 'تحليل الدم الشامل',
      createdAt: '2025-11-20 14:15:00',
      riskPercentage: 65,
      recommendation: 'يرجى مراجعة طبيب باطنة في أقرب وقت.',
      symptomsSelected: [
        SymptomsSelected(name: 'ارتفاع ضغط الدم'),
        SymptomsSelected(name: 'دوخة مستمرة'),
      ],
    ),
    Assessment(
      id: 103,
      reason: 'فحص الحساسية',
      createdAt: '2025-10-15 11:00:00',
      riskPercentage: 5,
      recommendation: 'لا توجد ملاحظات، الصحة جيدة.',
      symptomsSelected: [],
    ),
  ];

  @override
  void initState() {
    super.initState();
    filteredAssessments = assessments;
  }

  void _filterAssessments(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredAssessments = assessments;
      } else {
        filteredAssessments = assessments.where((assessment) {
          final reason = assessment.reason?.toString().toLowerCase() ?? '';
          final date = assessment.createdAt?.toString().toLowerCase() ?? '';
          final searchLower = query.toLowerCase();
          return reason.contains(searchLower) || date.contains(searchLower);
        }).toList();
      }
    });
  }

  void _deleteAssessment(int id) {
    setState(() {
      assessments.removeWhere((element) => element.id == id);
      _filterAssessments(searchController.text);
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('تم حذف السجل بنجاح')));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(kDefPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'سجل التشخيصات',
              style: TextStyle(
                color: kTextColor,
                fontSize: 4.5.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            CustomTextFormField(
              prefixIcon: Icon(
                Icons.search,
                size: 6.5.sp,
                color: kSubTextColor,
              ),
              controller: searchController,
              text: '',
              labelText: 'البحث في السجلات...',
              onChanged: _filterAssessments,
              validator: (String? p1) {
                return null;
              },
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 3.h),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 2.h),
                itemCount: filteredAssessments.length,
                itemBuilder: (context, index) {
                  final item = filteredAssessments[index];
                  return DiagnosisItem(
                    assessment: item,
                    onDelete: () => _deleteAssessment(item.id!),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
