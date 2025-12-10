import 'package:flutter/material.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/features/profile/view/widgets/custom_card.dart';
import 'package:medical_care/features/profile/view/widgets/custom_divider.dart';
import 'package:medical_care/settings/setting_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 24),

              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: kPrimryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            'أ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 10,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 14,
                            color: kPrimryColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  // Name
                  Text(
                    'أحمد محمد',
                    style: TextStyle(
                      fontSize: 18,

                      fontWeight: FontWeight.w700,
                      color: kTextColor,
                    ),
                  ),

                  SizedBox(height: 8),

                  // Email
                  Text(
                    'ahmed@example.com',
                    style: TextStyle(fontSize: 14, color: kSubTextColor),
                  ),

                  SizedBox(height: 24),

                  // Edit Profile Button
                  SizedBox(
                    width: 160,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'تعديل الملف الشخصي',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40),

              // -------------------- Menu Items --------------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: CustomCard(
                        icon: Icons.person_outline,
                        title: 'المعلومات الشخصية',
                        iconColor: kSubTextColor,
                      ),
                    ),
                    CustomDivider(),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingView(),
                          ),
                        );
                      },
                      child: CustomCard(
                        icon: Icons.settings_outlined,
                        title: 'الإعدادات',

                        iconColor: kSubTextColor,
                      ),
                    ),
                    CustomDivider(),

                    CustomCard(
                      icon: Icons.privacy_tip_outlined,
                      title: 'سياسة الخصوصية',
                      iconColor: kSubTextColor,
                    ),
                    CustomDivider(),

                    CustomCard(
                      icon: Icons.description_outlined,
                      title: 'الشروط والأحكام',
                      iconColor: kSubTextColor,
                    ),
                    CustomDivider(),

                    CustomCard(
                      icon: Icons.contact_support_outlined,
                      title: 'تواصل معنا',
                      iconColor: kSubTextColor,
                    ),
                    CustomDivider(),

                    CustomCard(
                      icon: Icons.info_outline,
                      title: 'عن التطبيق',

                      iconColor: kSubTextColor,
                    ),
                    CustomDivider(),

                    CustomCard(
                      icon: Icons.logout_outlined,
                      title: 'تسجيل الخروج',

                      textColor: kRedColor,
                      iconContainerColor: kRedColor,
                      iconColor: kRedColor,
                    ),
                    Text('الاصدار 1.0.0', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
