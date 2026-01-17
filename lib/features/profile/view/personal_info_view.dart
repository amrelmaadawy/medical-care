import 'package:flutter/material.dart';
import 'package:medical_care/core/components/custom_elevated_button.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/features/profile/view/edit_profile_view.dart';

class PersonalInformationView extends StatelessWidget {
  const PersonalInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'المعلومات الشخصية',
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
            _buildInfoItem('الاسم الكامل', 'أحمد محمد', Icons.person_outline),
            _buildInfoItem(
              'البريد الإلكتروني',
              'ahmed@example.com',
              Icons.email_outlined,
            ),
            _buildInfoItem('رقم الهاتف', '01012345678', Icons.phone_outlined),
            _buildInfoItem(
              'تاريخ الميلاد',
              '01/01/1990',
              Icons.calendar_today_outlined,
            ),
            _buildInfoItem('الجنس', 'ذكر', Icons.male_outlined),

            SizedBox(height: 40),
            CustomElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileView(),
                  ),
                );
              },
              text: 'تعديل البيانات',
              width: double.infinity,
              widget: Text(
                'تعديل البيانات',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              borderColor: Colors.transparent,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kPrimryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: kPrimryColor, size: 20),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 12, color: kSubTextColor)),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
