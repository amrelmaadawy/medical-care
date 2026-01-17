import 'package:flutter/material.dart';
import 'package:medical_care/core/components/custom_elevated_button.dart';
import 'package:medical_care/core/components/custom_text_form_field.dart';
import 'package:medical_care/core/utils/app_colors.dart';

class ContactUsView extends StatelessWidget {
  ContactUsView({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'نحن هنا لمساعدتك. يرجى ملء النموذج أدناه وسنتواصل معك في أقرب وقت.',
              style: TextStyle(color: kSubTextColor, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            CustomTextFormField(
              controller: _nameController,
              labelText: 'الاسم',
              prefixIcon: Icon(Icons.person_outline, color: kPrimryColor),
              validator: (p0) => null,
              keyboardType: TextInputType.name,
              text: '',
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              controller: _emailController,
              labelText: 'البريد الإلكتروني',
              prefixIcon: Icon(Icons.email_outlined, color: kPrimryColor),
              validator: (p0) => null,
              keyboardType: TextInputType.emailAddress,
              text: '',
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              controller: _messageController,
              labelText: 'رسالتك',
              validator: (p0) => null,
              text: '',
              maxLines: 5,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(height: 40),
            CustomElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('تم إرسال رسالتك بنجاح')),
                );
                Navigator.pop(context);
              },
              text: 'إرسال الرسالة',
              width: double.infinity,
              widget: Text(
                'إرسال الرسالة',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              borderColor: Colors.transparent,
              textColor: Colors.white,
            ),

            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIcon(Icons.facebook),
                SizedBox(width: 20),
                _buildSocialIcon(Icons.email),
                SizedBox(width: 20),
                _buildSocialIcon(Icons.phone),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kPrimryColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: kPrimryColor),
    );
  }
}
