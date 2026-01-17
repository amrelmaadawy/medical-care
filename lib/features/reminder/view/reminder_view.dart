import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';
import 'package:medical_care/features/reminder/model_view/reminder_cubit.dart';
import 'package:medical_care/features/reminder/view/add_reminder.dart';
import 'package:medical_care/features/reminder/view/widgets/reminder_item.dart';

class ReminderView extends StatelessWidget {
  const ReminderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReminderCubit()..getAllReminders(),
      child: Builder(
        builder: (builderContext) {
          return Padding(
            padding: const EdgeInsets.all(kDefPadding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'التذكيرات الطبية',
                      style: TextStyle(fontSize: 5.sp, color: kTextColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          builderContext,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: builderContext.read<ReminderCubit>(),
                              child: AddReminder(),
                            ),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 6.sp,
                        backgroundColor: kPrimryColor,
                        child: Icon(Icons.add, color: Colors.white, size: 6.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Expanded(
                  child: BlocBuilder<ReminderCubit, ReminderState>(
                    builder: (context, state) {
                      // نأخذ القائمة من الـ Cubit مباشرة وليس من الـ state فقط
                      final allReminders = context
                          .read<ReminderCubit>()
                          .reminders;

                      // حالة التحميل الأولية فقط (عندما تكون القائمة فارغة تماماً)
                      if (state is GetReminderLoading && allReminders.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      // حالة الخطأ والقائمة فارغة
                      if (state is GetReminderError && allReminders.isEmpty) {
                        return Center(child: Text('حدث خطأ في جلب البيانات'));
                      }

                      // عرض القائمة في كل الحالات الأخرى (Success أو تحديثات صامتة)
                      if (allReminders.isEmpty) {
                        return const Center(
                          child: Text('لا توجد تذكيرات طبية'),
                        );
                      }

                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: allReminders.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 2.h),
                        itemBuilder: (context, index) =>
                            ReminderItem(reminderModel: allReminders[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
