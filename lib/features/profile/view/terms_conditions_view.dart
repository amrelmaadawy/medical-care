import 'package:flutter/material.dart';
import 'package:medical_care/core/utils/app_colors.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الشروط والأحكام',
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
            Text(
              'آخر تحديث: ٠١ يناير ٢٠٢٦',
              style: TextStyle(color: kSubTextColor, fontSize: 14),
            ),
            SizedBox(height: 20),
            _buildSection(
              '١. مقدمة',
              'مرحبًا بك في تطبيق الرعاية الطبية. باستخدامك لهذا التطبيق، فإنك توافق على الالتزام بالشروط والأحكام التالية. يرجى قراءتها بعناية.',
            ),
            _buildSection(
              '٢. الاستخدام المسموح به',
              'يُسمح لك باستخدام التطبيق لأغراض شخصية وغير تجارية فقط. يحظر استخدام التطبيق بأي طريقة قد تتسبب في ضرر للخدمة أو تعطيلها.',
            ),
            _buildSection(
              '٣. الخصوصية',
              'نحن نحترم خصوصيتك ونلتزم بحماية بياناتك الشخصية وفقًا لسياسة الخصوصية الخاصة بنا.',
            ),
            _buildSection(
              '٤. المحتوى الطبي',
              'المحتوى المقدم في هذا التطبيق هو لأغراض إعلامية فقط ولا يعتبر بديلاً عن الاستشارة الطبية المتخصصة. استشر طبيبك دائمًا.',
            ),
            _buildSection(
              '٥. التعديلات',
              'نحتفظ بالحق في تعديل هذه الشروط في أي وقت. سيتم إشعارك بأي تغييرات جوهرية.',
            ),
            SizedBox(height: 20),
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
