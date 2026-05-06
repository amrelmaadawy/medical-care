import 'dart:convert';

class Exception {
  int? id;
  int? reminderId;
  String? date;
  String? action;
  dynamic newTime;
  String? createdAt;
  String? updatedAt;

  Exception({
    this.id,
    this.reminderId,
    this.date,
    this.action,
    this.newTime,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'Exception(id: $id, reminderId: $reminderId, date: $date, action: $action, newTime: $newTime, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory Exception.fromMap(Map<String, dynamic> data) => Exception(
    id: data['id'] as int?,
    reminderId: data['reminder_id'] as int?,
    date: data['date'] as String?,
    action: data['action'] as String?,
    newTime: data['new_time'] as dynamic,
    createdAt: data['created_at'] as String?,
    updatedAt: data['updated_at'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'reminder_id': reminderId,
    'date': date,
    'action': action,
    'new_time': newTime,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Exception].
  factory Exception.fromJson(String data) {
    return Exception.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Exception] to a JSON string.
  String toJson() => json.encode(toMap());

  Exception copyWith({
    int? id,
    int? reminderId,
    String? date,
    String? action,
    dynamic newTime,
    String? createdAt,
    String? updatedAt,
  }) {
    return Exception(
      id: id ?? this.id,
      reminderId: reminderId ?? this.reminderId,
      date: date ?? this.date,
      action: action ?? this.action,
      newTime: newTime ?? this.newTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
