import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/core/components/custom_elevated_button.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';
import 'package:medical_care/core/utils/frequancy_maping.dart';
import 'package:medical_care/features/reminder/model/reminder_model/reminder_model.dart';
import 'package:medical_care/features/reminder/model_view/reminder_cubit.dart';

class ReminderItem extends StatelessWidget {
  const ReminderItem({super.key, required this.reminderModel});
  final ReminderModel reminderModel;

  @override
  Widget build(BuildContext context) {
    // حذفنا الـ BlocBuilder من هنا لزيادة الأداء
    return SizedBox(
      height: 19.h,
      child: Card(
        color: Colors.white,
        elevation: 0.5, // إضافة ظل خفيف لشكل أشيك
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefBorderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              // أيقونة التذكير
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
                  size: 24,
                ),
              ),
              SizedBox(width: 4.w),
              // تفاصيل التذكير
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      reminderModel.title ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                      ),
                    ),
                    Text(
                      "${reminderModel.recurrenceRules![0].time} - ${getRecurrenceArabic(reminderModel.recurrenceRules![0].frequency!)}",
                      style: TextStyle(fontSize: 14, color: kSubTextColor),
                    ),
                    const SizedBox(height: 8),
                    // زر الحذف
                    CustomElevatedButton(
                      widget: Icon(
                        Icons.delete_outline_outlined,
                        color: kRedColor,
                        size: 5.sp,
                      ),
                      text: '',
                      borderColor: kHghtLightRedColor,
                      textColor: kRedColor,
                      width: 18.w,
                      onPressed: () async {
                        await context.read<ReminderCubit>().deletReminder(
                          id: reminderModel.id!,
                        );
                      },
                    ),
                  ],
                ),
              ),
              // زر التشغيل/الإيقاف
              Switch(
                value: reminderModel.active == 1,
                onChanged: (v) {
                  context.read<ReminderCubit>().editActiveReminder(
                    id: reminderModel.id!,
                    active: v ? 1 : 0,
                  );
                },
                activeColor: kPrimryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
