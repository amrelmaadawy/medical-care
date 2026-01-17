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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // تهيئة SizeConfig لضمان قراءة أبعاد الموبايل الحقيقي فوراً
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefPadding),
          child: Column(
            children: [
              // زر التخطي
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => _navigateToSignUp(),
                  child: Text(
                    'تخطي',
                    style: TextStyle(
                      color: kSubTextColor, 
                      fontSize: 16, 
                    ),
                  ),
                ),
              ),

              // محتوى الـ Onboarding
              Expanded(
                child: PageView(
                  controller: _pageController,
                  // إزالة const لضمان إعادة البناء السليم عند أول تحميل
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
                      subTitle: 'احصل على تشخيص سريع ودقيق لجدري الماء باستخدام تقنية الذكاء الاصطناعي المتقدمة',
                    ),
                    OnboardingPage(
                      icon: Icons.file_upload_outlined,
                      iconColor: kBoardingGreenColor,
                      iconBGColor: kHghtLightonBoardingGreenColor,
                      title: 'قم برفع الصورة والأعراض',
                      subTitle: 'التقط صورة للطفح الجلدي وأدخل الأعراض للحصول على تقييم شامل وموثوق',
                    ),
                    OnboardingPage(
                      icon: Icons.chat_bubble_outline,
                      iconColor: kOrangeColor,
                      iconBGColor: kHghtLightOrangeColor,
                      title: 'استشارة طبية ونصائح',
                      subTitle: 'تواصل مع الأطباء المتخصصين واحصل على نصائح طبية موثوقة على مدار الساعة',
                    ),
                  ],
                ),
              ),

              // مؤشر النقاط
              SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: kPrimryColor,
                  dotColor: Colors.grey.shade300,
                  expansionFactor: 4,
                  spacing: 8,
                ),
              ),

              SizedBox(height: 4.h),

              // الأزرار السفلية
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // زر التالي / ابدأ الآن
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kDefBorderRadius),
                      ),
                      minimumSize: Size(40.w, 6.h),
                    ),
                    onPressed: () {
                      if (currentPage == 2) {
                        _navigateToSignUp();
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      currentPage == 2 ? 'ابدأ الآن' : 'التالي',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  // زر السابق
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: kPrimryColor),
                        borderRadius: BorderRadius.circular(kDefBorderRadius),
                      ),
                      minimumSize: Size(40.w, 6.h),
                    ),
                    onPressed: currentPage == 0
                        ? null
                        : () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                    child: Text(
                      'السابق',
                      style: TextStyle(
                        fontSize: 16,
                        color: currentPage == 0 ? Colors.grey : kPrimryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToSignUp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignUpView()),
    );
  }
}