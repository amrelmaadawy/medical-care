import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';
import 'package:medical_care/features/auth/data/auth_repo.dart';
import 'package:medical_care/features/auth/signup/signup_viewmodel.dart';
import 'package:medical_care/features/auth/signup/widgets/custom_text_filed.dart';
import 'package:medical_care/features/layout/view/layout_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupCubit(AuthRepo()),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocConsumer<SignupCubit, SignupState>(
            listener: (context, state) {
              if (state is SignupSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LayoutView()),
                );
              } else if (state is SignupError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is SignupLoading;

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
                        const Text(
                          'إنشاء حساب جديد',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),

                        // Subtitle
                        const Text(
                          'انضم إلينا لبدأ رحله التشخيص الطبي',
                          style: TextStyle(fontSize: 16, color: kSubTextColor),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 32),

                        // Full name field
                        CustomTextField(
                          controller: _nameController,
                          hintText: 'أدخل الاسم الكامل',
                          labelText: 'الاسم الكامل',
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'الاسم الكامل مطلوب';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Email field
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'أدخل البريد الإلكتروني',
                          labelText: 'البريد الإلكتروني',
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
                        ),

                        const SizedBox(height: 16),

                        // Password field with eye icon
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'أدخل كلمة المرور',
                          labelText: 'كلمة المرور',
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
                        ),

                        const SizedBox(height: 16),

                        CustomTextField(
                          controller: _confirmPasswordController,
                          hintText: 'أعد إدخال كلمة المرور',
                          labelText: 'تأكيد كلمة المرور',
                          obscureText: _obscureConfirmPassword,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'تأكيد كلمة المرور مطلوب';
                            }
                            if (v != _passwordController.text) {
                              return 'كلمتي المرور غير متطابقتين';
                            }
                            return null;
                          },
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: kSubTextColor,
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
                                text: const TextSpan(
                                  text: 'أوافق على ',
                                  style: TextStyle(fontSize: 13, color: kTextColor),
                                  children: [
                                    TextSpan(
                                      text: 'الشروط والأحكام و سياسة الخصوصية',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: kPrimryColor,
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
                            onPressed: isLoading
                                ? null
                                : () {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }
                                    if (!_agreeToTerms) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('يرجى الموافقة على الشروط والأحكام'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                      return;
                                    }
                                    context.read<SignupCubit>().signup(
                                          name: _nameController.text.trim(),
                                          email: _emailController.text.trim(),
                                          password: _passwordController.text,
                                          passwordConfirmation: _confirmPasswordController.text,
                                        );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimryColor,
                              disabledBackgroundColor: kPrimryColor.withValues(alpha: 0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(kDefBorderRadius),
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
                                    'إنشاء الحساب',
                                    style: TextStyle(
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
                            const Text('لديك حساب؟ ', style: TextStyle(fontSize: 13)),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Text(
                                'تسجيل الدخول',
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
