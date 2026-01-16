import 'package:flutter/material.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'widgets/custom_container.dart';
import 'widgets/settings_item.dart';
import 'widgets/settings_switch_item.dart';
import 'widgets/settings_divider.dart';
import 'widgets/section_title.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimryColor,
        elevation: 0,
        title: const Text(
          'الإعدادات',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(title: 'إعدادات الحساب'),
                const SizedBox(height: 12),
                CustomContainer(
                  child: Column(
                    children: [
                      SettingsItem(
                        icon: Icons.lock_outline,
                        title: 'تغيير كلمة المرور',
                        onTap: () {},
                      ),
                      const SettingsDivider(),
                      SettingsItem(
                        icon: Icons.email_outlined,
                        title: 'البريد الإلكتروني',
                        subtitle: 'ahmed@example.com',
                        onTap: () {},
                      ),
                      const SettingsDivider(),
                      SettingsItem(
                        icon: Icons.phone_outlined,
                        title: 'رقم الهاتف',
                        subtitle: '+966 50 123 4567',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(title: 'إعدادات الإشعارات'),
                const SizedBox(height: 12),
                CustomContainer(
                  child: Column(
                    children: [
                      SettingsSwitchItem(
                        icon: Icons.notifications_outlined,
                        title: 'تفعيل الإشعارات',
                        value: true,
                        onTap: () {},
                        onChanged: (value) {},
                      ),
                      const SettingsDivider(),
                      SettingsSwitchItem(
                        icon: Icons.alarm_outlined,
                        title: 'إشعارات التذكيرات',
                        value: true,
                        onTap: () {},
                        onChanged: (value) {},
                      ),
                      const SettingsDivider(),
                      SettingsSwitchItem(
                        icon: Icons.chat_outlined,
                        title: 'إشعارات المحادثات',
                        value: true,
                        onTap: () {},
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(title: 'إعدادات التطبيق'),
                const SizedBox(height: 12),
                CustomContainer(
                  child: Column(
                    children: [
                      SettingsItem(
                        icon: Icons.language_outlined,
                        title: 'اللغة',
                        subtitle: 'العربية',
                        onTap: () {},
                      ),
                      const SettingsDivider(),
                      SettingsItem(
                        icon: Icons.palette_outlined,
                        title: 'المظهر',
                        subtitle: 'فاتح',
                        onTap: () {},
                      ),
                      const SettingsDivider(),
                      SettingsItem(
                        icon: Icons.text_fields_outlined,
                        title: 'حجم الخط',
                        subtitle: 'متوسط',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(title: 'البيانات والخصوصية'),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: CustomContainer(
                    child: Column(
                      children: [
                        SettingsItem(
                          icon: Icons.delete_outline,
                          title: 'حذف البيانات',
                          onTap: () {},
                        ),
                        const SettingsDivider(),
                        SettingsItem(
                          icon: Icons.download_outlined,
                          title: 'تصدير البيانات',
                          onTap: () {},
                        ),
                        const SettingsDivider(),
                        SettingsItem(
                          icon: Icons.delete_forever_outlined,
                          title: 'حذف الحساب',
                          onTap: () {},
                          iconColor: Colors.red,
                          textColor: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
