import 'package:medical_care/core/helper/dio_helper.dart';
import 'package:medical_care/features/reminder/model/reminder_model/recurrence_rule.dart';
import 'package:medical_care/features/reminder/model/reminder_model/reminder_model.dart';
import 'package:medical_care/features/reminder/repo/reminder_repo.dart';

class ReminderApi extends ReminderRepo {
  DioHelper dio = DioHelper();

  @override
  Future<void> deleteReminderData() {
    throw UnimplementedError();
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
    await dio.postData('https://graduation.coderaeg.com/api/reminders', {
      "title": title,
      "description": description,
      "active": active,
      "recurrence_rules": [{
        "frequency":recurrenceRules.frequency,
        "interval": recurrenceRules.interval,
        "time": recurrenceRules.time,
        "start_date": recurrenceRules.startDate,
        "end_date":recurrenceRules.endDate,
      },]
    });
  }

  @override
  Future<void> updateReminderData() {
    throw UnimplementedError();
  }
}
//post data
/* {
    "title": "Take Medication",
    "description": "Take antibiotic after food",
    "active": true,
    "recurrence_rules": [
        {
            "frequency": "daily",
            "interval": 1,
            "time": "09:00",
            "start_date": "2025-12-04",
            "end_date": "2025-12-31"
        },
        {
            "frequency": "weekly",
            "interval": 1,
            "days_of_week": [1, 3, 5],
            "time": "14:00",
            "start_date": "2025-12-04",
            "end_date": "2026-01-31"
        },
        {
            "frequency": "monthly",
            "interval": 1,
            "days_of_month": [1, 15],
            "time": "08:00",
            "start_date": "2025-12-04"
        },
        {
            "frequency": "yearly",
            "interval": 1,
            "months_of_year": [1, 6, 12],
            "days_of_month": [1],
            "time": "10:00",
            "start_date": "2025-12-04"
        }
    ],
    "exceptions": [
        {
            "date": "2025-12-25",
            "action": "skip"
        },
        {
            "date": "2025-12-31",
            "action": "modify",
            "new_time": "12:00"
        }
    ]
}* */