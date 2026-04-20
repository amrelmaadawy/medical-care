import 'dart:convert';
import 'package:medical_care/core/helper/type_parser.dart';
import 'package:medical_care/features/history/model/assessments/assessment.dart';
import 'package:medical_care/features/history/model/assessments/symptoms_selected.dart';

class LatestAssessment {
  int? id;
  int? userId;
  List<String>? imagePath;
  int? riskPercentage;
  dynamic recommendation;
  dynamic recommendationEn;
  dynamic reportText;
  dynamic symptomsText;
  List<dynamic>? symptomsSelected;
  String? status;
  String? statusEn;
  dynamic reason;
  String? createdAt;
  String? updatedAt;

  LatestAssessment({
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
    return 'LatestAssessment(id: $id, userId: $userId, imagePath: $imagePath, riskPercentage: $riskPercentage, recommendation: $recommendation, recommendationEn: $recommendationEn, reportText: $reportText, symptomsText: $symptomsText, symptomsSelected: $symptomsSelected, status: $status, statusEn: $statusEn, reason: $reason, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory LatestAssessment.fromMap(Map<String, dynamic> data) {
    return LatestAssessment(
      id: TypeParser.parseInt(data['id']),
      userId: TypeParser.parseInt(data['user_id']),
      imagePath: TypeParser.parseList<dynamic>(data['image_path'])
          ?.map((e) => e.toString())
          .toList(),
      riskPercentage: TypeParser.parseInt(data['risk_percentage']),
      recommendation: data['recommendation'],
      recommendationEn: data['recommendation_en'],
      reportText: data['report_text'],
      symptomsText: data['symptoms_text'],
      symptomsSelected: TypeParser.parseList<dynamic>(data['symptoms_selected']),
      status: TypeParser.parseString(data['status']),
      statusEn: TypeParser.parseString(data['status_en']),
      reason: data['reason'],
      createdAt: TypeParser.parseString(data['created_at']),
      updatedAt: TypeParser.parseString(data['updated_at']),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'user_id': userId,
    'image_path': imagePath,
    'risk_percentage': riskPercentage,
    'recommendation': recommendation,
    'recommendation_en': recommendationEn,
    'report_text': reportText,
    'symptoms_text': symptomsText,
    'symptoms_selected': symptomsSelected,
    'status': status,
    'status_en': statusEn,
    'reason': reason,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };

  factory LatestAssessment.fromJson(String data) {
    return LatestAssessment.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  LatestAssessment copyWith({
    int? id,
    int? userId,
    List<String>? imagePath,
    int? riskPercentage,
    dynamic recommendation,
    dynamic recommendationEn,
    dynamic reportText,
    dynamic symptomsText,
    List<dynamic>? symptomsSelected,
    String? status,
    String? statusEn,
    dynamic reason,
    String? createdAt,
    String? updatedAt,
  }) {
    return LatestAssessment(
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

  Assessment toAssessment() {
    return Assessment(
      id: id,
      userId: userId,
      imagePath: imagePath,
      riskPercentage: riskPercentage,
      recommendation: recommendation,
      recommendationEn: recommendationEn,
      reportText: reportText,
      symptomsText: symptomsText?.toString(),
      symptomsSelected: symptomsSelected
          ?.map((e) => SymptomsSelected.fromMap(e as Map<String, dynamic>))
          .toList(),
      status: status,
      statusEn: statusEn,
      reason: reason,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
