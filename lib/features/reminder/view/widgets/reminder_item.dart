import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/core/components/custom_elevated_button.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';
import 'package:medical_care/features/reminder/model/reminder_model/reminder_model.dart';
import 'package:medical_care/features/reminder/model_view/reminder_cubit.dart';

class ReminderItem extends StatelessWidget {
  const ReminderItem({super.key, required this.reminderModel});
  final ReminderModel reminderModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderCubit, ReminderState>(
      builder: (context, state) {
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
                          borderRadius: BorderRadius.circular(
                            kDefBorderRadius - 5,
                          ),
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
                        reminderModel.recurrenceRules![0].time!,
                        style: TextStyle(
                          fontSize: 3.8.sp,
                          color: kSubTextColor,
                        ),
                      ),
                      Text(
                        reminderModel.recurrenceRules![0].frequency!,
                        style: TextStyle(
                          fontSize: 3.8.sp,
                          color: kSubTextColor,
                        ),
                      ),

                      Row(
                        children: [
                          CustomElevatedButton(
                            widget: Icon(
                              Icons.edit_outlined,
                              color: kPrimryColor,
                              size: 5.sp,
                            ),
                            text: '',
                            borderColor: kHghtLightBlueColor,
                            textColor: kPrimryColor,
                            width: 18.w,
                            onPressed: () {},
                          ),
                          SizedBox(width: 3.w),
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

                      // InkWell(
                      //   onTap: () async {
                      //     await context.read<ReminderCubit>().deletReminder(
                      //       id: reminderModel.id!,
                      //     );
                      //   },
                      //   child: Row(
                      //     children: [
                      //       Icon(
                      //         Icons.delete_outline,
                      //         color: kRedColor,
                      //         size: 7.sp,
                      //       ),
                      //       Text(
                      //         'حذف التذكير',
                      //         style: TextStyle(
                      //           fontSize: 3.5.sp,
                      //           color: kRedColor,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  Spacer(),
                  Switch(
                    value: reminderModel.active == 1 ? true : false,
                    onChanged: (v) {
                      context.read<ReminderCubit>().editActiveReminder(
                        id: reminderModel.id!,
                        active: v==true?1:0,
                      );
                    },
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
      },
    );
  }
}
