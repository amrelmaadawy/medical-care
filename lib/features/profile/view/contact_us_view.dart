import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/core/components/custom_elevated_button.dart';
import 'package:medical_care/core/components/custom_text_form_field.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/features/profile/data/contact_repo.dart';
import 'package:medical_care/features/profile/model_view/contact_cubit.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactCubit(ContactRepo()),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text(
              'تواصل معنا',
              style: TextStyle(
                color: kTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: BackButton(color: kTextColor),
          ),
          body: BlocConsumer<ContactCubit, ContactState>(
            listener: (context, state) {
              if (state is ContactSuccess) {
                // Clear the form
                _nameController.clear();
                _emailController.clear();
                _messageController.clear();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم إرسال رسالتك بنجاح'),
                    backgroundColor: kPrimryColor,
                  ),
                );
                Navigator.pop(context);
              } else if (state is ContactError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is ContactLoading;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      const Text(
                        'نحن هنا لمساعدتك. يرجى ملء النموذج أدناه وسنتواصل معك في أقرب وقت.',
                        style: TextStyle(color: kSubTextColor, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),

                      // Name field
                      CustomTextFormField(
                        controller: _nameController,
                        labelText: 'الاسم',
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: kPrimryColor,
                        ),
                        keyboardType: TextInputType.name,
                        text: '',
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'الاسم مطلوب';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Email field
                      CustomTextFormField(
                        controller: _emailController,
                        labelText: 'البريد الإلكتروني',
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: kPrimryColor,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        text: '',
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
                      const SizedBox(height: 20),

                      // Message field
                      CustomTextFormField(
                        controller: _messageController,
                        labelText: 'رسالتك',
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        text: '',
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'الرسالة مطلوبة';
                          }
                          if (v.trim().length < 10) {
                            return 'الرسالة قصيرة جداً (10 أحرف على الأقل)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),

                      // Send button
                      CustomElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (!_formKey.currentState!.validate()) return;
                                context.read<ContactCubit>().sendMessage(
                                  name: _nameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  message: _messageController.text.trim(),
                                );
                              },
                        text: isLoading ? '' : 'إرسال الرسالة',
                        width: double.infinity,
                        buttonColor: kPrimryColor,
                        borderColor: kPrimryColor,
                        textColor: Colors.white,
                        widget: isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : null,
                      ),

                      const SizedBox(height: 40),

                      // Social icons (decorative — unchanged)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialIcon(Icons.facebook),
                          const SizedBox(width: 20),
                          _buildSocialIcon(Icons.email),
                          const SizedBox(width: 20),
                          _buildSocialIcon(Icons.phone),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kPrimryColor.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: kPrimryColor),
    );
  }
}
