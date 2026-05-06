import 'package:flutter/material.dart';
import 'package:medical_care/core/utils/app_colors.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'سياسة الخصوصية',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'جمع المعلومات',
              'نحن نجمع المعلومات التي تقدمها لنا مباشرة عند استخدام التطبيق، مثل المعلومات الشخصية والبيانات الصحية.',
            ),
            _buildSection(
              'استخدام المعلومات',
              'نستخدم المعلومات لتحسين خدماتنا وتخصيص تجربتك، وكذلك للتواصل معك بشأن التحديثات المهمة.',
            ),
            _buildSection(
              'مشاركة المعلومات',
              'لا نشارك معلوماتك الشخصية مع أطراف ثالثة إلا في الحالات التي يقتضيها القانون أو لحماية حقوقنا.',
            ),
            _buildSection(
              'أمان البيانات',
              'نحن نتخذ تدابير أمنية مناسبة لحماية بياناتك من الوصول غير المصرح به أو التغيير أو الإفشاء.',
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'إذا كان لديك أي أسئلة، يرجى التواصل معنا.',
                style: TextStyle(color: kSubTextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kPrimryColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(fontSize: 14, color: kTextColor, height: 1.6),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
