import 'package:flutter/material.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';

import 'package:medical_care/features/layout/view/layout_view.dart';
import '../signin/signin_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon
                CircleAvatar(
                  radius: 11.sp,
                  backgroundColor: kPrimryColor,
                  child: Icon(
                    Icons.health_and_safety_outlined,
                    color: Colors.white,
                    size: 13.sp,
                  ),
                ),
                const SizedBox(height: 32),

                // Title
                Text(
                  'التشخيص الطبي',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                // Subtitle
                Text(
                  'مرحباً بك في تطبيق التشخيص الطبي',
                  style: TextStyle(fontSize: 14, color: kSubTextColor),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                // Email / phone label
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'البريد الإلكتروني أو رقم الهاتف',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kTextColor,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Email / phone field
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kgreyHighlightColor,
                    hintText: 'أدخل البريد الإلكتروني أو رقم الهاتف',
                    hintStyle: TextStyle(color: kSubTextColor, fontSize: 14),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kDefBorderRadius),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kDefBorderRadius),
                      borderSide: const BorderSide(
                        color: kPrimryColor,
                        width: 1,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Password label
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'كلمة المرور',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kTextColor,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Password field with eye icon
                TextField(
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kgreyHighlightColor,
                    hintText: 'أدخل كلمة المرور',
                    hintStyle: TextStyle(color: kSubTextColor, fontSize: 14),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: kSubTextColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kDefBorderRadius),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kDefBorderRadius),
                      borderSide: const BorderSide(
                        color: kPrimryColor,
                        width: 1,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Forgot password + Remember me
                Row(
                  children: [
                    // Remember me
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (_) {},
                            visualDensity: VisualDensity.compact,
                          ),
                          Text('تذكرني', style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                    // Forgot password
                    Text(
                      'نسيت كلمة المرور؟',
                      style: TextStyle(fontSize: 13, color: kPrimryColor),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LayoutView(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kDefBorderRadius),
                      ),
                    ),
                    child: Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Create account text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('ليس لديك حساب؟ ', style: TextStyle(fontSize: 13)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInView(),
                          ),
                        );
                      },
                      child: Text(
                        'إنشاء حساب جديد',
                        style: TextStyle(
                          fontSize: 13,
                          color: kPrimryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 26),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
