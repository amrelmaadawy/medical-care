import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/frequancy_maping.dart';
import 'package:medical_care/features/reminder/model/reminder_model/reminder_model.dart';
import 'package:medical_care/features/reminder/model_view/reminder_cubit.dart';

class ReminderItem extends StatelessWidget {
  const ReminderItem({super.key, required this.reminderModel});
  final ReminderModel reminderModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Icon Container
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kPrimryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.medication_outlined,
                color: kPrimryColor,
                size: 24,
              ),
            ),
            SizedBox(width: 16),

            // Text Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reminderModel.title ?? "بدون عنوان",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  if (reminderModel.recurrenceRules != null &&
                      reminderModel.recurrenceRules!.isNotEmpty)
                    Text(
                      "${_formatTime(reminderModel.recurrenceRules![0].time)} - ${getRecurrenceArabic(reminderModel.recurrenceRules![0].frequency!)}",
                      style: TextStyle(
                        fontSize: 13,
                        color: kSubTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),

            // Active Switch
            Transform.scale(
              scale: 0.8,
              child: Switch(
                value: reminderModel.active == 1,
                activeColor: kPrimryColor,
                onChanged: (v) {
                  context.read<ReminderCubit>().editActiveReminder(
                    id: reminderModel.id!,
                    active: v ? 1 : 0,
                  );
                },
              ),
            ),

            // More Options (Delete)
            PopupMenuButton<int>(
              icon: Icon(Icons.more_vert, color: kSubTextColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (item) {
                if (item == 0) {
                  _deleteReminder(context);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline, color: kRedColor, size: 20),
                      SizedBox(width: 8),
                      Text("حذف", style: TextStyle(color: kRedColor)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _deleteReminder(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("حذف التذكير"),
        content: Text("هل أنت متأكد من رغبتك في حذف هذا التذكير؟"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text("إلغاء")),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await context.read<ReminderCubit>().deletReminder(
                id: reminderModel.id!,
              );
            },
            child: Text("حذف", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  String _formatTime(String? time) {
    if (time == null) return "";
    // Basic formatting or leave as is if already formatted
    return time;
  }
}
