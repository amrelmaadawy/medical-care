import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeService {
  /// Pick Time - returns one formatted value only
  static Future<void> pickTime(
    BuildContext context,
    void Function(String value) onPick,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
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

    // قيمة واحدة فقط
    final value = DateFormat('HH:mm:ss').format(dateTime);

    onPick(value);
  }

  /// Pick Date (yyyy-MM-dd)
  static Future<void> pickDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      locale: const Locale("ar"),
    );

    if (picked == null) return;

    controller.text = DateFormat('yyyy-MM-dd').format(picked);
  }
}
