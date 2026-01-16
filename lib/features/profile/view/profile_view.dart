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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 24),

            /// -------------------- Profile Header --------------------
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: kPrimryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
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
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 14,
                          color: kPrimryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Text(
                  'أحمد محمد',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: kTextColor,
                  ),
                ),
                const SizedBox(height: 8),

                Text(
                  'ahmed@example.com',
                  style: TextStyle(fontSize: 14, color: kPrimryColor),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
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

            const SizedBox(height: 40),

            /// -------------------- Menu --------------------
            Column(
              children: [
                CustomCard(
                  icon: Icons.person_outline,
                  title: 'المعلومات الشخصية',
                  iconColor: kPrimryColor,
                ),
                CustomDivider(),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingView()),
                    );
                  },
                  child: CustomCard(
                    icon: Icons.settings_outlined,
                    title: 'الإعدادات',
                    iconColor: kPrimryColor,
                  ),
                ),
                CustomDivider(),

                CustomCard(
                  icon: Icons.privacy_tip_outlined,
                  title: 'سياسة الخصوصية',
                  iconColor: kPrimryColor,
                ),
                CustomDivider(),

                CustomCard(
                  icon: Icons.description_outlined,
                  title: 'الشروط والأحكام',
                  iconColor: kPrimryColor,
                ),
                CustomDivider(),

                CustomCard(
                  icon: Icons.contact_support_outlined,
                  title: 'تواصل معنا',
                  iconColor: kPrimryColor,
                ),
                CustomDivider(),

                CustomCard(
                  icon: Icons.info_outline,
                  title: 'عن التطبيق',
                  iconColor: kPrimryColor,
                ),
                CustomDivider(),

                CustomCard(
                  icon: Icons.logout_outlined,
                  title: 'تسجيل الخروج',
                  textColor: kRedColor,
                  iconContainerColor: kHghtLightRedColor,
                  iconColor: kRedColor,
                ),

                const SizedBox(height: 12),
                const Text('الإصدار 1.0.0', style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
