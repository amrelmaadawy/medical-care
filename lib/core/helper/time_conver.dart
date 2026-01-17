import 'package:intl/intl.dart';

String formatTimeForApi(String timeString) {
  // 1. خريطة تحويل الأرقام العربية/الهندية إلى إنجليزية
  Map<String, String> arabicNumbers = {
    '٠': '0', '١': '1', '٢': '2', '٣': '3', '٤': '4',
    '٥': '5', '٦': '6', '٧': '7', '٨': '8', '٩': '9',
  };

  // 2. استبدال الأرقام
  String cleanTime = timeString;
  arabicNumbers.forEach((key, value) {
    cleanTime = cleanTime.replaceAll(key, value);
  });

  // 3. استبدال رموز الصباح والمساء العربية بالإنجليزية ليفهمها الـ DateFormat
  cleanTime = cleanTime.replaceAll('ص', 'AM').replaceAll('صباحاً', 'AM');
  cleanTime = cleanTime.replaceAll('م', 'PM').replaceAll('مساءً', 'PM');

  try {
    // 4. محاولة قراءة الوقت وتنسيقه لنظام 24 ساعة
    // إذا كان الوقت أصلاً 12 ساعة (مثلاً 03:30 PM) سيحوله لـ 15:30
    DateTime parsedTime;
    if (cleanTime.toLowerCase().contains('am') || cleanTime.toLowerCase().contains('pm')) {
      parsedTime = DateFormat('hh:mm a', 'en').parse(cleanTime.trim());
    } else {
      parsedTime = DateFormat('HH:mm', 'en').parse(cleanTime.trim());
    }

    return DateFormat('HH:mm', 'en').format(parsedTime);
  } catch (e) {
    // في حالة حدوث خطأ، نرجع النص الأصلي مع تنظيف الأرقام فقط
    return cleanTime.trim();
  }
}

String formatDateForApi(String dateString) {
  // 1. خريطة تحويل الأرقام العربية/الهندية إلى إنجليزية
  Map<String, String> arabicNumbers = {
    '٠': '0', '١': '1', '٢': '2', '٣': '3', '٤': '4',
    '٥': '5', '٦': '6', '٧': '7', '٨': '8', '٩': '9',
  };

  // 2. تنظيف النص من الأرقام العربية
  String cleanDate = dateString;
  arabicNumbers.forEach((key, value) {
    cleanDate = cleanDate.replaceAll(key, value);
  });

  try {
    // 3. محاولة التعرف على التاريخ وتنسيقه للصيغة العالمية (2025-01-17)
    // نستخدم التنسيقات المتوقعة من الـ Picker
    DateTime parsedDate;
    if (cleanDate.contains('-')) {
      parsedDate = DateFormat('yyyy-MM-dd', 'en').parse(cleanDate.trim());
    } else if (cleanDate.contains('/')) {
      parsedDate = DateFormat('yyyy/MM/dd', 'en').parse(cleanDate.trim());
    } else {
      parsedDate = DateTime.parse(cleanDate.trim());
    }

    return DateFormat('yyyy-MM-dd', 'en').format(parsedDate);
  } catch (e) {
    // في حالة الخطأ نرجع النص المنظف كما هو
    return cleanDate.trim();
  }
}