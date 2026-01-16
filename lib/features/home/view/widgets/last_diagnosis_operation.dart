import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';
import 'package:medical_care/features/home/model_view/home_cubit/home_cubit.dart';

class LastDiagnosisOperation extends StatelessWidget {
  const LastDiagnosisOperation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state is GetHomeDataSuccess
            ? Card(
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
                        '${state.homeModel.latestAssessment!.createdAt}',
                        style: TextStyle(
                          fontSize: 3.5.sp,
                          color: kSubTextColor,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        children: [
                          Text(
                            'مستوى الخطورة ',
                            style: TextStyle(fontSize: 4.sp, color: kTextColor),
                          ),
                          Text(
                            '${state.homeModel.latestAssessment!.riskPercentage ?? 'كحكه روح اعمل التشخيص عدل'}',
                            style: TextStyle(
                              color: kGreenColor,
                              fontSize: 4.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.sp),
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
              )
            : Text('شغل النت يعاااااام');
      },
    );
  }
}
