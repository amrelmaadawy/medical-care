import 'package:flutter/material.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';
import 'package:medical_care/features/reminder/model/reminder_model/reminder_model.dart';

class ReminderItem extends StatelessWidget {
  const ReminderItem({super.key,required this.reminderModel});
        final ReminderModel reminderModel;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 18.h,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefBorderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 15.w,
                    height: 15.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kDefBorderRadius - 5),
                      color: kHghtLightBlueColor,
                    ),
                    child: Icon(
                      Icons.notifications_outlined,
                      color: kPrimryColor,
                      size: 7.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 5.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                  reminderModel.title!,
                    style: TextStyle(
                      fontSize: 4.2.sp,
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'الساعة 8:00 صباحاً',
                    style: TextStyle(fontSize: 3.8.sp, color: kSubTextColor),
                  ),
                  Text(
                    'التكرار: يومي',
                    style: TextStyle(fontSize: 3.8.sp, color: kSubTextColor),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_outline,
                          color: kRedColor,
                          size: 7.sp,
                        ),
                        Text(
                          'حذف التذكير',
                          style: TextStyle(fontSize: 3.5.sp, color: kRedColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              Switch(
                value: reminderModel.active==1?true:false,
                onChanged: (v) {},
                activeThumbColor: kHghtLightBlueColor,
                activeTrackColor: kPrimryColor,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: kgreyColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
