import 'dart:convert';

import 'assessment.dart';
import 'pagination.dart';

class Assessments {
  List<Assessment>? assessments;
  Pagination? pagination;

  Assessments({this.assessments, this.pagination});

  @override
  String toString() {
    return 'Assessments(assessments: $assessments, pagination: $pagination)';
  }

  factory Assessments.fromMap(Map<String, dynamic> data) => Assessments(
    assessments: (data['assessments'] as List<dynamic>?)
        ?.map((e) => Assessment.fromMap(e as Map<String, dynamic>))
        .toList(),
    pagination: data['pagination'] == null
        ? null
        : Pagination.fromMap(data['pagination'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {
    'assessments': assessments?.map((e) => e.toMap()).toList(),
    'pagination': pagination?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Assessments].
  factory Assessments.fromJson(String data) {
    return Assessments.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Assessments] to a JSON string.
  String toJson() => json.encode(toMap());

  Assessments copyWith({
    List<Assessment>? assessments,
    Pagination? pagination,
  }) {
    return Assessments(
      assessments: assessments ?? this.assessments,
      pagination: pagination ?? this.pagination,
    );
  }
}
