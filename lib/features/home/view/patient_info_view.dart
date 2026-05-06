import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';
import 'package:medical_care/features/home/model_view/symbot_cubit/symbot_cubit.dart';

class PatientInfoView extends StatefulWidget {
  final PageController pageController;

  const PatientInfoView({super.key, required this.pageController});

  @override
  State<PatientInfoView> createState() => _PatientInfoViewState();
}

class _PatientInfoViewState extends State<PatientInfoView> {
  final _ageController = TextEditingController();
  final _durationController = TextEditingController();
  String _selectedGender = 'Male';

  @override
  void dispose() {
    _ageController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefPadding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  'بيانات المريض الإضافية',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 5.sp,
                    color: kTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'تساعدنا هذه البيانات على توفير دقة أعلى في التحليل',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 3.5.sp, color: kSubTextColor),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            
            Text('العمر (اختياري)', style: TextStyle(color: kTextColor, fontSize: 4.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 1.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(kDefBorderRadius),
                border: Border.all(color: kgreyHighlightColor),
              ),
              child: TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'أدخل العمر...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            
            SizedBox(height: 2.h),
            Text('الجنس (اختياري)', style: TextStyle(color: kTextColor, fontSize: 4.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 1.h),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(kDefBorderRadius),
                border: Border.all(color: kgreyHighlightColor),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedGender,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: 'Male', child: Text('ذكر')),
                    DropdownMenuItem(value: 'Female', child: Text('أنثى')),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedGender = val);
                  },
                ),
              ),
            ),

            SizedBox(height: 2.h),
            Text('مدة استمرار الأعراض بالأيام (اختياري)', style: TextStyle(color: kTextColor, fontSize: 4.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 1.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(kDefBorderRadius),
                border: Border.all(color: kgreyHighlightColor),
              ),
              child: TextField(
                controller: _durationController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'مثال: 3 أيام...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            
            SizedBox(height: 5.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kDefBorderRadius),
                ),
                minimumSize: Size(double.infinity, 7.h),
              ),
              onPressed: () {
                final cubit = context.read<SymbotCubit>();
                
                final parsedAge = int.tryParse(_ageController.text.trim());
                if (parsedAge != null) cubit.patientAge = parsedAge;
                
                cubit.patientGender = _selectedGender;
                
                final parsedDuration = int.tryParse(_durationController.text.trim());
                if (parsedDuration != null) cubit.durationDays = parsedDuration;

                cubit.submitDiagnosis();
              },
              child: Text(
                'بدء التحليل',
                style: TextStyle(
                  fontSize: 5.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
