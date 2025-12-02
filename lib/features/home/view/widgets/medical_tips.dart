import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:medical_care/features/home/view/widgets/custom_medical_tips_card.dart';

class MedicalTips extends StatelessWidget {
  const MedicalTips({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CustomMedicalTipsCard(
            icon: FontAwesomeIcons.pills,
            title: 'الأدوية',
            subTitle: 'التزم بمواعيد الأدوية المحددة',
          ),
          CustomMedicalTipsCard(
            icon: FontAwesomeIcons.stethoscope,
            title: 'الفحص الدوري',
            subTitle: ' قم بالفحص الطبي كل 6 أشهر',
          ),
          CustomMedicalTipsCard(
            icon: FontAwesomeIcons.heart,
            title: 'شرب الماء',
            subTitle: 'احرص على شرب 8 أكواب ماء يومياً',
          ),
        ],
      ),
    );
  }
}