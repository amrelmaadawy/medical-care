import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';
import 'package:medical_care/core/utils/pref_helper.dart';
import 'package:medical_care/features/auth/data/auth_repo.dart';
import 'package:medical_care/features/auth/signin/signin_view.dart';
import 'package:medical_care/features/auth/signin/signin_viewmodel.dart';
import 'package:medical_care/features/profile/view/widgets/custom_card.dart';
import 'package:medical_care/features/profile/view/widgets/custom_divider.dart';
import 'package:medical_care/settings/setting_view.dart';
import 'package:medical_care/features/profile/view/edit_profile_view.dart';
import 'package:medical_care/features/profile/view/personal_info_view.dart';
import 'package:medical_care/features/profile/view/terms_conditions_view.dart';
import 'package:medical_care/features/profile/view/contact_us_view.dart';
import 'package:medical_care/features/profile/view/about_app_view.dart';
import 'package:medical_care/features/profile/view/privacy_policy_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String _userName = '';
  String _userEmail = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final name = await PrefHelper.getName();
    final email = await PrefHelper.getEmail();
    if (mounted) {
      setState(() {
        _userName = name ?? 'المستخدم';
        _userEmail = email ?? '';
      });
    }
  }

  Future<bool> _showLogoutDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تسجيل الخروج', textDirection: TextDirection.rtl),
        content: const Text(
          'هل أنت متأكد من تسجيل الخروج؟',
          textDirection: TextDirection.rtl,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'تسجيل الخروج',
              style: TextStyle(color: kRedColor),
            ),
          ),
        ],
      ),
    );
    return confirmed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LogoutCubit(AuthRepo()),
      child: BlocListener<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const SignInView()),
              (route) => false,
            );
          } else if (state is LogoutError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Builder(
          builder: (context) => Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 24),

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
                            child: Center(
                              child: Text(
                                _userName.isNotEmpty ? _userName[0] : 'U',
                                style: const TextStyle(
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
                        _userName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: kTextColor,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        _userEmail,
                        style: TextStyle(fontSize: 14, color: kPrimryColor),
                      ),
                      const SizedBox(height: 24),

                      SizedBox(
                        width: 160,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditProfileView(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                kDefBorderRadius,
                              ),
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

                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PersonalInformationView(),
                            ),
                          );
                        },
                        child: CustomCard(
                          icon: Icons.person_outline,
                          title: 'المعلومات ��لشخصية',
                          iconColor: kPrimryColor,
                        ),
                      ),
                      CustomDivider(),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SettingView(),
                            ),
                          );
                        },
                        child: CustomCard(
                          icon: Icons.settings_outlined,
                          title: 'الإعدادات',
                          iconColor: kPrimryColor,
                        ),
                      ),
                      CustomDivider(),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PrivacyPolicyView(),
                            ),
                          );
                        },
                        child: CustomCard(
                          icon: Icons.privacy_tip_outlined,
                          title: 'سياسة الخصوصية',
                          iconColor: kPrimryColor,
                        ),
                      ),
                      CustomDivider(),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const TermsAndConditionsView(),
                            ),
                          );
                        },
                        child: CustomCard(
                          icon: Icons.description_outlined,
                          title: 'الشروط والأحكام',
                          iconColor: kPrimryColor,
                        ),
                      ),
                      CustomDivider(),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContactUsView(),
                            ),
                          );
                        },
                        child: CustomCard(
                          icon: Icons.contact_support_outlined,
                          title: 'تواصل معنا',
                          iconColor: kPrimryColor,
                        ),
                      ),
                      CustomDivider(),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AboutAppView(),
                            ),
                          );
                        },
                        child: CustomCard(
                          icon: Icons.info_outline,
                          title: 'عن التطبيق',
                          iconColor: kPrimryColor,
                        ),
                      ),
                      CustomDivider(),

                      BlocBuilder<LogoutCubit, LogoutState>(
                        builder: (context, state) {
                          final isLoading = state is LogoutLoading;
                          return GestureDetector(
                            onTap: isLoading
                                ? null
                                : () async {
                                    final confirmed = await _showLogoutDialog();
                                    if (confirmed && context.mounted) {
                                      context.read<LogoutCubit>().logout();
                                    }
                                  },
                            child: isLoading
                                ? const Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: kRedColor,
                                      ),
                                    ),
                                  )
                                : CustomCard(
                                    icon: Icons.logout_outlined,
                                    title: 'تسجيل الخروج',
                                    textColor: kRedColor,
                                    iconContainerColor: kHghtLightRedColor,
                                    iconColor: kRedColor,
                                  ),
                          );
                        },
                      ),

                      const SizedBox(height: 12),
                      const Text(
                        'الإصدار 1.0.0',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
