import 'package:medical_care/core/helper/dio_helper.dart';
import 'package:medical_care/features/reminder/model/reminder_model/recurrence_rule.dart';
import 'package:medical_care/features/reminder/model/reminder_model/reminder_model.dart';
import 'package:medical_care/features/reminder/repo/reminder_repo.dart';

class ReminderApi extends ReminderRepo {
  DioHelper dio = DioHelper();

  @override
  Future<void> deleteReminderData({required int id}) async {
    await dio.deletData('https://graduation.coderaeg.com/api/reminders/$id');
    print('deleted Successfully=============================');
  }

  @override
  Future<List<ReminderModel>> getReminderData() async {
    var response = await dio.getData(
      'https://graduation.coderaeg.com/api/reminders',
    );
    var list = response.data['data'] as List;
    var reminders = list.map((e) => ReminderModel.fromMap((e))).toList();
    print(reminders);
    return reminders;
  }
@override
Future<void> postReminderData({
  required String title,
  required String description,
  bool active = true,
  required RecurrenceRule recurrenceRules,
}) async {
  // تأكد من تحويل كل القيم لنصوص أو أرقام صريحة
  final Map<String, dynamic> data = {
    "title": title,
    "description": description,
    "active": active ? 1 : 0, // تحويل لـ int لضمان التوافق
    "recurrence_rules": [
      {
        "frequency": recurrenceRules.frequency ?? "daily",
        "interval": recurrenceRules.interval ?? 1,
        "time": recurrenceRules.time,
        "start_date": recurrenceRules.startDate,
        "end_date": recurrenceRules.endDate,
      },
    ],
  };

  await dio.postData('https://graduation.coderaeg.com/api/reminders', data);
}

  @override
  Future<void> updateReminderData({
    required String title,
    required String description,
    bool active = true,
    required RecurrenceRule recurrenceRules,
    required int id,
  }) async {
    await dio.putData('https://graduation.coderaeg.com/api/reminders/$id', {
      "title": title,
      "active": active,

      "description": description,
      "reminder_date": recurrenceRules.startDate,
      "reminder_time": recurrenceRules.time,
      "frequency": recurrenceRules.frequency,
    });
  }

  @override
  Future<void> editActiveReminderData({
    required int id,
    required int active,
  }) async {
    await dio.putData('https://graduation.coderaeg.com/api/reminders/$id', {
      "active": active,
    });
  }

  @override
  Future<void> getReminderById({required int id}) async {
    await dio.getData('https://graduation.coderaeg.com/api/reminders/$id');
  }
}
