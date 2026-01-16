
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';
import 'package:medical_care/features/home/model_view/symbot_cubit/symbot_cubit.dart';

class ChooseTheSympotms extends StatelessWidget {
  const ChooseTheSympotms({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SymbotCubit, SymbotState>(
      builder: (context, state) {
        return state is GetSymptomsError
            ? Text('ما تشغل النت يفلاح هجيب الداتا ازاي')
            : state is GetSymptomsSuccess
            ? Padding(
                padding: const EdgeInsets.all(kDefPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListTile(
                      title: Text(
                        'اختر الأعراض الموجودة',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 5.sp,
                          color: kTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        'حدد جميع الأعراض التي تلاحظها',
                        style: TextStyle(
                          fontSize: 3.5.sp,
                          color: kSubTextColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1.3,
                            ),
                        itemCount: state.symbol.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: ()
                            {
                              
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  kDefBorderRadius,
                                ),
                                border: Border.all(color: kPrimryColor),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      state.symbol[index].name!,
                                      style: TextStyle(
                                        fontSize: 4.sp,
                                        color: kTextColor,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      state.symbol[index].description!,
                                      style: TextStyle(
                                        fontSize: 3.5.sp,
                                        color: kTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 2.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            kDefBorderRadius,
                          ),
                        ),
                        minimumSize: Size(double.infinity, 7.h),
                      ),
                      onPressed: () {
                        pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text(
                        ' التالي',
                        style: TextStyle(
                          fontSize: 5.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}
