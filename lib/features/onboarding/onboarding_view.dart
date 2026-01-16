import 'package:flutter/material.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';
import 'package:medical_care/features/auth/signup/signup_view.dart';
import 'package:medical_care/features/onboarding/widgets/onboarding_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kDefPadding),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  child: Text(
                    'تخطي',
                    style: TextStyle(color: kSubTextColor, fontSize: 3.5.sp),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpView()),
                    );
                  },
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  children: [
                    OnboardingPage(
                      icon: Icons.auto_awesome_outlined,
                      iconColor: kPrimryColor,
                      iconBGColor: kHghtLightBlueColor,
                      title: 'تشخيص ذكي بالذكاء الاصطناعي',
                      subTitle:
                          'احصل على تشخيص سريع ودقيق لجدري الماء باستخدام تقنية الذكاء الاصطناعي المتقدمة',
                    ),
                    OnboardingPage(
                      icon: Icons.file_upload_outlined,
                      iconColor: kBoardingGreenColor,
                      iconBGColor: kHghtLightonBoardingGreenColor,
                      title: 'قم برفع الصورة والأعراض',
                      subTitle:
                          'التقط صورة للطفح الجلدي وأدخل الأعراض للحصول على تقييم شامل وموثوق',
                    ),
                    OnboardingPage(
                      icon: Icons.chat_bubble_outline,
                      iconColor: kOrangeColor,
                      iconBGColor: kHghtLightOrangeColor,
                      title: 'استشارة طبية ونصائح',
                      subTitle:
                          'تواصل مع الأطباء المتخصصين واحصل على نصائح طبية موثوقة على مدار الساعة',
                    ),
                  ],
                ),
              ),

              SmoothPageIndicator(
                controller: _pageController,
                count: 3,

                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Colors.blue,
                  dotColor: Colors.grey.shade300,
                  expansionFactor: 4,
                  spacing: 8,
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kDefBorderRadius),
                      ),
                      minimumSize: Size(40.w, 6.h),
                    ),
                    onPressed: () {
                      currentPage == 2
                          ? Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpView(),
                              ),
                            )
                          : _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                    },
                    child: currentPage == 2
                        ? Text(
                            ' ابداء الان ',
                            style: TextStyle(
                              fontSize: 5.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Text(
                            'التالي',
                            style: TextStyle(
                              fontSize: 5.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: kPrimryColor),
                        borderRadius: BorderRadius.circular(kDefBorderRadius),
                      ),
                      minimumSize: Size(40.w, 6.h),
                    ),
                    onPressed: () {
                      setState(() {
                        currentPage == 0
                            ? null
                            : _pageController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                      });
                    },
                    child: Text(
                      ' السابق',
                      style: TextStyle(
                        fontSize: 5.sp,
                        color: kPrimryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
