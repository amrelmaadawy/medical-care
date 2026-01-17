import 'package:flutter/material.dart';
import 'package:medical_care/core/components/custom_elevated_button.dart';
import 'package:medical_care/core/components/custom_text_form_field.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController _nameController = TextEditingController(
    text: 'أحمد محمد',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'ahmed@example.com',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '01012345678',
  );
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تعديل الملف الشخصي',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              // Profile Picture
              Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
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
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: kPrimryColor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),

              // Fields
              CustomTextFormField(
                controller: _nameController,
                labelText: 'الاسم الكامل',
                prefixIcon: Icon(Icons.person_outline, color: kPrimryColor),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'يرجى إدخال الاسم';
                  return null;
                },
                keyboardType: TextInputType.name,
                text: '',
              ),
              SizedBox(height: 20),

              CustomTextFormField(
                controller: _phoneController,
                labelText: 'رقم الهاتف',
                prefixIcon: Icon(Icons.phone_outlined, color: kPrimryColor),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'يرجى إدخال رقم الهاتف';
                  return null;
                },
                keyboardType: TextInputType.phone,
                text: '',
              ),
              SizedBox(height: 20),

              CustomTextFormField(
                controller: _emailController,
                labelText: 'البريد الإلكتروني',
                prefixIcon: Icon(Icons.email_outlined, color: kPrimryColor),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'يرجى إدخال البريد الإلكتروني';
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                text: '',
              ),

              SizedBox(height: 40),

              CustomElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('تم حفظ التعديلات بنجاح')),
                    );
                    Navigator.pop(context);
                  }
                },
                text: 'حفظ التعديلات',
                width: double.infinity,
                widget: Text(
                  'حفظ التعديلات',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                borderColor: Colors.transparent,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
