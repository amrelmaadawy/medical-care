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
    if (state is GetReminderSuccess) {
      return state.reminders.isEmpty
          ? Center(child: Text('لا توجد تذكيرات'))
          : ListView.separated(
              itemBuilder: (context, index) => ReminderItem(
                reminderModel: state.reminders[index],
              ),
              separatorBuilder: (context, index) {
                return SizedBox(height: 2.h);
              },
              itemCount: state.reminders.length,
            );
    } else if (state is GetReminderLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (state is GetReminderError) {
      return Center(child: Text('حدث خطأ'));
    }
    return Center(child: Text(''));
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
