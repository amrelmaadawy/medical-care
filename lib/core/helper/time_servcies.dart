import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_care/core/utils/app_colors.dart';

class TimeService {
  static Future<void> pickTime(
    BuildContext context,
    void Function(String value) onPick,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: kPrimryColor, // لون الدائرة والمؤشر
              onPrimary: Colors.white, // لون الأرقام داخل الدائرة
              surface: kHghtLightBlueColor, // خلفية الساعة
              onSurface: Colors.black, // لون الأرقام والنصوص
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: kPrimryColor, // لون زر "موافق" و "إلغاء"
              ),
            ),
            dialogTheme: DialogThemeData(backgroundColor: kHghtLightBlueColor),
          ),
          child: Localizations.override(
            context: context,
            locale: const Locale('ar', 'EG'),

            child: child!,
          ),
        );
      },
    );

    if (picked == null) return;

    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      picked.hour,
      picked.minute,
    );

    final value = DateFormat('HH:mm').format(dateTime);
    onPick(value);
  }

  /// Pick Date - واجهة عربية
  static Future<void> pickDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      locale: const Locale("ar", "EG"), 
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: kPrimryColor, 
              onPrimary: Colors.white, 
              surface: kHghtLightBlueColor,
              onSurface: Colors.black, 
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: kPrimryColor,
              ),
            ),
            dialogTheme: DialogThemeData(backgroundColor:kHghtLightBlueColor),
          ),
          child: child!,
        );
      },
    );

    if (picked == null) return;

    controller.text = DateFormat('yyyy-MM-dd').format(picked);
  }
}
