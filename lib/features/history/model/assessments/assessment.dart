import 'dart:convert';

import 'symptoms_selected.dart';

class Assessment {
  int? id;
  int? userId;
  List<String>? imagePath;
  int? riskPercentage;
  dynamic recommendation;
  dynamic recommendationEn;
  dynamic reportText;
  String? symptomsText;
  List<SymptomsSelected>? symptomsSelected;
  String? status;
  String? statusEn;
  dynamic reason;
  String? createdAt;
  String? updatedAt;

  Assessment({
    this.id,
    this.userId,
    this.imagePath,
    this.riskPercentage,
    this.recommendation,
    this.recommendationEn,
    this.reportText,
    this.symptomsText,
    this.symptomsSelected,
    this.status,
    this.statusEn,
    this.reason,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'Assessment(id: $id, userId: $userId, imagePath: $imagePath, riskPercentage: $riskPercentage, recommendation: $recommendation, recommendationEn: $recommendationEn, reportText: $reportText, symptomsText: $symptomsText, symptomsSelected: $symptomsSelected, status: $status, statusEn: $statusEn, reason: $reason, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory Assessment.fromMap(Map<String, dynamic> data) => Assessment(
    id: data['id'] as int?,
    userId: data['user_id'] as int?,
    imagePath: data['image_path'] as List<String>?,
    riskPercentage: data['risk_percentage'] as int?,
    recommendation: data['recommendation'] as dynamic,
    recommendationEn: data['recommendation_en'] as dynamic,
    reportText: data['report_text'] as dynamic,
    symptomsText: data['symptoms_text'] as String?,
    symptomsSelected: (data['symptoms_selected'] as List<dynamic>?)
        ?.map((e) => SymptomsSelected.fromMap(e as Map<String, dynamic>))
        .toList(),
    status: data['status'] as String?,
    statusEn: data['status_en'] as String?,
    reason: data['reason'] as dynamic,
    createdAt: data['created_at'] as String?,
    updatedAt: data['updated_at'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'user_id': userId,
    'image_path': imagePath,
    'risk_percentage': riskPercentage,
    'recommendation': recommendation,
    'recommendation_en': recommendationEn,
    'report_text': reportText,
    'symptoms_text': symptomsText,
    'symptoms_selected': symptomsSelected?.map((e) => e.toMap()).toList(),
    'status': status,
    'status_en': statusEn,
    'reason': reason,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Assessment].
  factory Assessment.fromJson(String data) {
    return Assessment.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Assessment] to a JSON string.
  String toJson() => json.encode(toMap());

  Assessment copyWith({
    int? id,
    int? userId,
    List<String>? imagePath,
    int? riskPercentage,
    dynamic recommendation,
    dynamic recommendationEn,
    dynamic reportText,
    String? symptomsText,
    List<SymptomsSelected>? symptomsSelected,
    String? status,
    String? statusEn,
    dynamic reason,
    String? createdAt,
    String? updatedAt,
  }) {
    return Assessment(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      imagePath: imagePath ?? this.imagePath,
      riskPercentage: riskPercentage ?? this.riskPercentage,
      recommendation: recommendation ?? this.recommendation,
      recommendationEn: recommendationEn ?? this.recommendationEn,
      reportText: reportText ?? this.reportText,
      symptomsText: symptomsText ?? this.symptomsText,
      symptomsSelected: symptomsSelected ?? this.symptomsSelected,
      status: status ?? this.status,
      statusEn: statusEn ?? this.statusEn,
      reason: reason ?? this.reason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
