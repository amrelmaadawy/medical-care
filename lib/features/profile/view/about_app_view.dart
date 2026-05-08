import 'package:flutter/material.dart';
import 'package:medical_care/core/utils/app_colors.dart';

class AboutAppView extends StatelessWidget {
  const AboutAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'عن التطبيق',
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Simple Medical Health Logo.png',
                width: 140,
                height: 140,
              ),
              SizedBox(height: 30),
              Text(
                'الرعاية الطبية',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kTextColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'الإصدار 1.0.0',
                style: TextStyle(fontSize: 16, color: kSubTextColor),
              ),
              SizedBox(height: 40),
              Text(
                'تطبيق الرعاية الطبية هو رفيقك الصحي الشخصي. نهدف إلى تسهيل متابعة حالتك الصحية وتوفير الأدوات اللازمة للحفاظ على صحتك وسلامتك.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: kTextColor, height: 1.6),
              ),
              Spacer(),
              Text(
                '© ٢٠٢٦ جميع الحقوق محفوظة',
                style: TextStyle(fontSize: 12, color: kSubTextColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
