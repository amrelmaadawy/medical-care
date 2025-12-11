import 'dart:convert';

class RecurrenceRule {
  int? id;
  int? reminderId;
  String? frequency;
  int? interval;
  dynamic daysOfWeek;
  dynamic daysOfMonth;
  dynamic monthsOfYear;
  String? time;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;

  RecurrenceRule({
    this.id,
    this.reminderId,
    this.frequency,
    this.interval,
    this.daysOfWeek,
    this.daysOfMonth,
    this.monthsOfYear,
    this.time,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'RecurrenceRule(id: $id, reminderId: $reminderId, frequency: $frequency, interval: $interval, daysOfWeek: $daysOfWeek, daysOfMonth: $daysOfMonth, monthsOfYear: $monthsOfYear, time: $time, startDate: $startDate, endDate: $endDate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory RecurrenceRule.fromMap(Map<String, dynamic> data) {
    return RecurrenceRule(
      id: data['id'] as int?,
      reminderId: data['reminder_id'] as int?,
      frequency: data['frequency'] as String?,
      interval: data['interval'] as int?,
      daysOfWeek: data['days_of_week'] as dynamic,
      daysOfMonth: data['days_of_month'] as dynamic,
      monthsOfYear: data['months_of_year'] as dynamic,
      time: data['time'] as String?,
      startDate: data['start_date'] as String?,
      endDate: data['end_date'] as String?,
      createdAt: data['created_at'] as String?,
      updatedAt: data['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'reminder_id': reminderId,
    'frequency': frequency,
    'interval': interval,
    'days_of_week': daysOfWeek,
    'days_of_month': daysOfMonth,
    'months_of_year': monthsOfYear,
    'time': time,
    'start_date': startDate,
    'end_date': endDate,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RecurrenceRule].
  factory RecurrenceRule.fromJson(String data) {
    return RecurrenceRule.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RecurrenceRule] to a JSON string.
  String toJson() => json.encode(toMap());

  RecurrenceRule copyWith({
    int? id,
    int? reminderId,
    String? frequency,
    int? interval,
    dynamic daysOfWeek,
    dynamic daysOfMonth,
    dynamic monthsOfYear,
    String? time,
    String? startDate,
    String? endDate,
    String? createdAt,
    String? updatedAt,
  }) {
    return RecurrenceRule(
      id: id ?? this.id,
      reminderId: reminderId ?? this.reminderId,
      frequency: frequency ?? this.frequency,
      interval: interval ?? this.interval,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      daysOfMonth: daysOfMonth ?? this.daysOfMonth,
      monthsOfYear: monthsOfYear ?? this.monthsOfYear,
      time: time ?? this.time,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
