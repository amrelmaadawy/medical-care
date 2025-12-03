import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  
    const Color primaryColor = Color(0xFF2F80ED);
    const Color backgroundColor = Color(0xFFF7F9FC);
    const Color cardColor = Colors.white;
    const Color textColor = Colors.black87;
    const Color hintColor = Color(0xFFBDBDBD);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                  'التشخيص الطبي',
                  textDirection: TextDirection.rtl,
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
                  'مرحباً بك في تطبيق التشخيص الطبي',
                  style: GoogleFonts.tajawal(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                // Email / phone label
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'البريد الإلكتروني أو رقم الهاتف',
                    style: GoogleFonts.tajawal(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Email / phone field
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: cardColor,
                    hintText: 'أدخل البريد الإلكتروني أو رقم الهاتف',
                    hintStyle: GoogleFonts.tajawal(
                      color: hintColor,
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: primaryColor,
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
                    style: GoogleFonts.tajawal(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Password field with eye icon
                TextField(
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: cardColor,
                    hintText: 'أدخل كلمة المرور',
                    hintStyle: GoogleFonts.tajawal(
                      color: hintColor,
                      fontSize: 14,
                    ),
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
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: primaryColor,
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
                          Text(
                            'تذكرني',
                            style: GoogleFonts.tajawal(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    // Forgot password
                    Text(
                      'نسيت كلمة المرور؟',
                      style: GoogleFonts.tajawal(
                        fontSize: 13,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Login button
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
                      'تسجيل الدخول',
                      style: GoogleFonts.tajawal(
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
                    Text(
                      'ليس لديك حساب؟ ',
                      style: GoogleFonts.tajawal(fontSize: 13),
                    ),
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
          ),
        ),
      ),
    );
  }
}
