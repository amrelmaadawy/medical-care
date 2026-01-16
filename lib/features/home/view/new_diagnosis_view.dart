import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/features/home/model_view/symbot_cubit/symbot_cubit.dart';
import 'package:medical_care/features/home/view/done_uploading_view.dart';
import 'package:medical_care/features/home/view/upload_photo_view.dart';
import 'package:medical_care/features/home/view/choose_the_sympotms.dart';

class NewDiagnosisView extends StatefulWidget {
  const NewDiagnosisView({super.key});

  @override
  State<NewDiagnosisView> createState() => _NewDiagnosisViewState();
}

class _NewDiagnosisViewState extends State<NewDiagnosisView> {
  PageController pageController = PageController();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
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
            'رفع صورة الطفح الجلدي',
            style: TextStyle(fontSize: 3.5.sp, color: kSubTextColor),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => SymbotCubit()..getSymptoms(),
        child: SafeArea(
          child: PageView(
            controller: pageController,
            children: [
              UploadPhotoView(pageController: pageController),
              DoneUploadingView(pageController: pageController),
              ChooseTheSympotms(pageController: pageController),
            ],
          ),
        ),
      ),
    );
  }
}
