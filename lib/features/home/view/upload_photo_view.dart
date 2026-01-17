import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/features/home/model_view/symbot_cubit/symbot_cubit.dart';
import 'package:medical_care/core/helper/image_services.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';
import 'package:medical_care/features/home/view/widgets/custom_dotted_border_widget.dart';

class UploadPhotoView extends StatelessWidget {
  const UploadPhotoView({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: kHghtLightBlueColor,
              borderRadius: BorderRadius.circular(kDefBorderRadius),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.file_upload_outlined,
                size: 16.sp,
                color: kPrimryColor,
              ),
            ),
          ),
          SizedBox(height: 2.h),
          ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            title: Text(
              'قم برفع صورة الطفح الجلدي',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 5.sp,
                color: kTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              'للحصول على تشخيص دقيق، التقط صورة واضحة',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 3.8.sp, color: kSubTextColor),
            ),
          ),
          SizedBox(height: 2.h),

          CustomDottedBorderWidget(
            onTap: () async {
              await ImageService.pickImageFromCamera().then((image) {
                if (image != null) {
                  context.read<SymbotCubit>().updateImages([image]);
                  pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  color: kPrimryColor,
                  size: 8.sp,
                ),
                Text(
                  'التقاط صوره',
                  style: TextStyle(color: kTextColor, fontSize: 4.5.sp),
                ),
                Text(
                  'استخدم الكاميرا',
                  style: TextStyle(color: kSubTextColor, fontSize: 3.5.sp),
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          CustomDottedBorderWidget(
            onTap: () async {
              await ImageService.pickMultiImageFromGallery().then((images) {
                if (images != null && images.isNotEmpty) {
                  context.read<SymbotCubit>().updateImages(images);
                  pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.photo_library_outlined,
                  color: kPrimryColor,
                  size: 8.sp,
                ),
                Text(
                  ' اختر من المعرض',
                  style: TextStyle(color: kTextColor, fontSize: 4.5.sp),
                ),
                Text(
                  'رفع صوره موجوده',
                  style: TextStyle(color: kSubTextColor, fontSize: 3.5.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
