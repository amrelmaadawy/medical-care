import 'dart:convert';

import 'exception.dart';
import 'recurrence_rule.dart';

class ReminderModel {
  int? id;
  int? userId;
  String? title;
  String? description;
  int? active;
  List<RecurrenceRule>? recurrenceRules;
  List<Exception>? exceptions;
  String? createdAt;
  String? updatedAt;

  ReminderModel({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.active,
    this.recurrenceRules,
    this.exceptions,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'ReminderModel(id: $id, userId: $userId, title: $title, description: $description, active: $active, recurrenceRules: $recurrenceRules, exceptions: $exceptions, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory ReminderModel.fromMap(Map<String, dynamic> data) => ReminderModel(
    id: data['id'] as int?,
    userId: data['user_id'] as int?,
    title: data['title'] as String?,
    description: data['description'] as String?,
    active: data['active'] as int?,
    recurrenceRules: (data['recurrence_rules'] as List<dynamic>?)
        ?.map((e) => RecurrenceRule.fromMap(e as Map<String, dynamic>))
        .toList(),
    exceptions: (data['exceptions'] as List<dynamic>?)
        ?.map((e) => Exception.fromMap(e as Map<String, dynamic>))
        .toList(),
    createdAt: data['created_at'] as String?,
    updatedAt: data['updated_at'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'user_id': userId,
    'title': title,
    'description': description,
    'active': active,
    'recurrence_rules': recurrenceRules?.map((e) => e.toMap()).toList(),
    'exceptions': exceptions?.map((e) => e.toMap()).toList(),
    'created_at': createdAt,
    'updated_at': updatedAt,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ReminderModel].
  factory ReminderModel.fromJson(String data) {
    return ReminderModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ReminderModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ReminderModel copyWith({
    int? id,
    int? userId,
    String? title,
    String? description,
    int? active,
    List<RecurrenceRule>? recurrenceRules,
    List<Exception>? exceptions,
    String? createdAt,
    String? updatedAt,
  }) {
    return ReminderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      active: active ?? this.active,
      recurrenceRules: recurrenceRules ?? this.recurrenceRules,
      exceptions: exceptions ?? this.exceptions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
