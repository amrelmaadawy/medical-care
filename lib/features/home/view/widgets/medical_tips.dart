import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/features/home/model_view/home_cubit.dart';
import 'package:medical_care/features/home/view/widgets/custom_medical_tips_card.dart';

class MedicalTips extends StatelessWidget {
  const MedicalTips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SizedBox(
          height :15.h,
          child: state is GetHomeDataSuccess?
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount:state.homeModel.medicalAdvices!.length ,
            itemBuilder: (context, index) {
              
              return 
                  Row(
                      children: [
                        CustomMedicalTipsCard(
                          icon: FontAwesomeIcons.pills,
                          title: state.homeModel.medicalAdvices![index].title??'مش لاقي الاسم',
                          subTitle: state.homeModel.medicalAdvices![index].desc??'جيس وات مش لاقي الديسكريبشن كمان',
                        ),
                      ],
                    );
            
            },
          ) : Text('ما تشغل النت يفلاح هجيب الداتا ازاي')
        );
      },
    );
  }
}
