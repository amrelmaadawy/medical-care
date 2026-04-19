import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';
import 'package:medical_care/features/auth/data/auth_repo.dart';
import 'package:medical_care/features/auth/signin/signin_viewmodel.dart';
import 'package:medical_care/features/auth/signup/signup_view.dart';
import 'package:medical_care/features/layout/view/layout_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SigninCubit(AuthRepo()),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocConsumer<SigninCubit, SigninState>(
            listener: (context, state) {
              if (state is SigninSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LayoutView()),
                );
              } else if (state is SigninError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is SigninLoading;

              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),

                        // أيقونة
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

                        // العنوان
                        const Text(
                          'التشخيص الطبي',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),

                        const Text(
                          'مرحباً بك في تطبيق التشخيص الطبي',
                          style: TextStyle(fontSize: 14, color: kSubTextColor),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),

                        // ── حقل البريد الإلكتروني ──────────────────────────
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'البريد الإلكتروني',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: kTextColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'البريد الإلكتروني مطلوب';
                            }
                            if (!v.contains('@')) {
                              return 'أدخل بريداً إلكترونياً صحيحاً';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: kgreyHighlightColor,
                            hintText: 'أدخل البريد الإلكتروني',
                            hintStyle: const TextStyle(
                                color: kSubTextColor, fontSize: 14),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(kDefBorderRadius),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(kDefBorderRadius),
                              borderSide: const BorderSide(
                                  color: kPrimryColor, width: 1),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(kDefBorderRadius),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(kDefBorderRadius),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.5),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // ── حقل كلمة المرور ────────────────────────────────
                        const Align(
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
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'كلمة المرور مطلوبة';
                            }
                            if (v.length < 6) {
                              return 'كلمة المرور قصيرة جداً';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: kgreyHighlightColor,
                            hintText: 'أدخل كلمة المرور',
                            hintStyle: const TextStyle(
                                color: kSubTextColor, fontSize: 14),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: kSubTextColor,
                              ),
                              onPressed: () => setState(
                                  () => _obscurePassword = !_obscurePassword),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(kDefBorderRadius),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(kDefBorderRadius),
                              borderSide: const BorderSide(
                                  color: kPrimryColor, width: 1),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(kDefBorderRadius),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(kDefBorderRadius),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.5),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // ── نسيت كلمة المرور ──────────────────────────────
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: false,
                                    onChanged: (_) {},
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  const Text('تذكرني',
                                      style: TextStyle(fontSize: 13)),
                                ],
                              ),
                            ),
                            const Text(
                              'نسيت كلمة المرور؟',
                              style:
                                  TextStyle(fontSize: 13, color: kPrimryColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),

                        // ── زر تسجيل الدخول ───────────────────────────────
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }
                                    context.read<SigninCubit>().signin(
                                          email: _emailController.text.trim(),
                                          password: _passwordController.text,
                                        );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimryColor,
                              disabledBackgroundColor:
                                  kPrimryColor.withValues(alpha: 0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(kDefBorderRadius),
                              ),
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : const Text(
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

                        // ── إنشاء حساب جديد ───────────────────────────────
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('ليس لديك حساب؟ ',
                                style: TextStyle(fontSize: 13)),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SignUpView()),
                              ),
                              child: const Text(
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
              );
            },
          ),
        ),
      ),
    );
  }
}
