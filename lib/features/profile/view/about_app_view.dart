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
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: kPrimryColor,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: kPrimryColor.withOpacity(0.3),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.medical_services_outlined,
                  size: 60,
                  color: Colors.white,
                ),
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
