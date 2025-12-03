import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/widgets/custom_text_field.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;
  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF2F80ED);
    const Color backgroundColor = Color(0xFFF7F9FC);
    const Color textColor = Colors.black87;
    const Color hintColor = Color(0xFFBDBDBD);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Stack(
              children: [
                // Back arrow

                // Centered content
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),

                    // Icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2F80ED),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Title
                    Text(
                      'إنشاء حساب جديد',
                      style: GoogleFonts.tajawal(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),

                    // Subtitle
                    Text(
                      'انضم إلينا لبدأ رحله التشخيص الطبي',
                      style: GoogleFonts.tajawal(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 32),

                    // Full name field
                    CustomTextField(
                      hintText: 'أدخل الاسم الكامل',
                      labelText: 'الاسم الكامل',
                    ),

                    const SizedBox(height: 16),

                    // Email field
                    CustomTextField(
                      hintText: 'أدخل البريد الإلكتروني',
                      labelText: 'البريد الإلكتروني',
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 16),

                    // Phone number field
                    CustomTextField(
                      hintText: 'أدخل رقم الهاتف',
                      labelText: 'رقم الهاتف',
                      keyboardType: TextInputType.phone,
                    ),

                    const SizedBox(height: 16),

                    // Password field with eye icon
                    CustomTextField(
                      hintText: 'أدخل كلمة المرور',
                      labelText: 'كلمة المرور',
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: hintColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Confirm password field with eye icon
                    CustomTextField(
                      hintText: 'أعد إدخال كلمة المرور',
                      labelText: 'تأكيد كلمة المرور',
                      obscureText: _obscureConfirmPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: hintColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Terms and conditions checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: _agreeToTerms,
                          onChanged: (value) {
                            setState(() {
                              _agreeToTerms = value ?? false;
                            });
                          },
                          visualDensity: VisualDensity.compact,
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: 'أوافق على ',
                              style: GoogleFonts.tajawal(
                                fontSize: 13,
                                color: textColor,
                              ),
                              children: [
                                TextSpan(
                                  text: 'الشروط والأحكام و سياسة الخصوصية',
                                  style: GoogleFonts.tajawal(
                                    fontSize: 13,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Create account button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'إنشاء الحساب',
                          style: GoogleFonts.tajawal(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Already have account text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'لديك حساب؟ ',
                          style: GoogleFonts.tajawal(fontSize: 13),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            'تسجيل الدخول',
                            style: GoogleFonts.tajawal(
                              fontSize: 13,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 26),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
