import 'package:flutter/material.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'widgets/custom_container.dart';
import 'widgets/settings_item.dart';
import 'widgets/settings_switch_item.dart';
import 'widgets/settings_divider.dart';
import 'widgets/section_title.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  bool isNotifyEnabled = true;
  bool isReminderEnabled = true;
  bool isChatEnabled = true;

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
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'سيتم إرسال رابط تغيير كلمة المرور',
                              ),
                              backgroundColor: kPrimryColor,
                            ),
                          );
                        },
                      ),
                      const SettingsDivider(),
                      SettingsItem(
                        icon: Icons.email_outlined,
                        title: 'البريد الإلكتروني',
                        subtitle: 'ahmed@example.com',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'لا يمكن تغيير البريد الإلكتروني حاليا',
                              ),
                              backgroundColor: kOrangeColor,
                            ),
                          );
                        },
                      ),
                      const SettingsDivider(),
                      SettingsItem(
                        icon: Icons.phone_outlined,
                        title: 'رقم الهاتف',
                        subtitle: '+966 50 123 4567',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('سيتم فتح صفحة تعديل الرقم'),
                              backgroundColor: kPrimryColor,
                            ),
                          );
                        },
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
                        value: isNotifyEnabled,
                        onTap: () {
                          setState(() {
                            isNotifyEnabled = !isNotifyEnabled;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            isNotifyEnabled = value;
                          });
                        },
                      ),
                      const SettingsDivider(),
                      SettingsSwitchItem(
                        icon: Icons.alarm_outlined,
                        title: 'إشعارات التذكيرات',
                        value: isReminderEnabled,
                        onTap: () {
                          setState(() {
                            isReminderEnabled = !isReminderEnabled;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            isReminderEnabled = value;
                          });
                        },
                      ),
                      const SettingsDivider(),
                      SettingsSwitchItem(
                        icon: Icons.chat_outlined,
                        title: 'إشعارات المحادثات',
                        value: isChatEnabled,
                        onTap: () {
                          setState(() {
                            isChatEnabled = !isChatEnabled;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            isChatEnabled = value;
                          });
                        },
                      ),
                    ],
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
