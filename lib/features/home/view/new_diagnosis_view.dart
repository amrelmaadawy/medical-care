import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/features/home/model_view/symbot_cubit/symbot_cubit.dart';
import 'package:medical_care/features/home/model_view/home_cubit/home_cubit.dart';
import 'package:medical_care/features/home/view/done_uploading_view.dart';
import 'package:medical_care/features/home/view/upload_photo_view.dart';
import 'package:medical_care/features/home/view/choose_the_sympotms.dart';
import 'package:medical_care/features/home/view/patient_info_view.dart';
import 'package:medical_care/features/history/view/report_view.dart';
import 'package:medical_care/features/history/model/assessments/assessment.dart';
import 'package:medical_care/features/history/model/assessments/symptoms_selected.dart';

class NewDiagnosisView extends StatefulWidget {
  const NewDiagnosisView({super.key});

  @override
  State<NewDiagnosisView> createState() => _NewDiagnosisViewState();
}

class _NewDiagnosisViewState extends State<NewDiagnosisView> {
  PageController pageController = PageController();
  
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        title: ListTile(
          title: Text(
            'تشخيص جديد',
            style: TextStyle(
              fontSize: 5.sp,
              color: kTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            'قيّم حالتك ببضع خطوات بسيطة',
            style: TextStyle(fontSize: 3.5.sp, color: kSubTextColor),
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SymbotCubit()..getSymptoms()),
          BlocProvider(create: (context) => HomeCubit()),
        ],
        child: Builder(
          builder: (context) {
            return BlocListener<SymbotCubit, SymbotState>(
              listener: (context, state) {
                if (state is SubmitDiagnosisLoading) {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                } else if (state is SubmitDiagnosisError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error), backgroundColor: Colors.red),
                  );
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                } else if (state is SubmitDiagnosisSuccess) {
                  final data = state.result['data'];
                  if (data != null) {
                    final analysis = data['ai_analysis'] ?? {};
                    final percentage = analysis['confidence_percentage'];

                    final rawSymptoms = data['patient_data']?['reported_symptoms']?.toString() ?? '';
                    final symptomsList = rawSymptoms.isNotEmpty ? rawSymptoms.split('،') : [];

                    final am = Assessment(
                      id: data['id'],
                      userId: data['user']?['id'],
                      imagePath: data['image_url'] != null ? [data['image_url']] : null,
                      reason: analysis['diagnosis'], 
                      symptomsSelected: symptomsList.map((s) => SymptomsSelected(name: s.trim())).toList(),
                      riskPercentage: percentage is int ? percentage : int.tryParse(percentage?.toString() ?? '0'),
                      recommendation: analysis['recommendation'],
                      createdAt: data['created_at']?.toString(),
                      updatedAt: data['created_at']?.toString(),
                    );

                    // Use a more reliable navigation approach
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        context.read<HomeCubit>().getHomeData();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => ReportView(assessment: am),
                          ),
                        );
                      }
                    });
                  } else {
                    // Handle case where data is null
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('حدث خطأ في استلام البيانات'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                }
              },
              child: SafeArea(
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    UploadPhotoView(pageController: pageController),
                    DoneUploadingView(pageController: pageController),
                    ChooseTheSympotms(pageController: pageController),
                    PatientInfoView(pageController: pageController),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 12.sp,
                          backgroundColor: kHghtLightGreenColor,
                          child: Icon(Icons.check, color: kGreenColor, size: 12.sp),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          'تم الانتهاء من التحليل',
                          style: TextStyle(
                            fontSize: 5.sp,
                            color: kTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'جاري الانتقال لنتائج التقييم....',
                          style: TextStyle(
                            fontSize: 4.sp,
                            color: kSubTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
