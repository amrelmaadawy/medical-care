import 'dart:convert';

import 'package:medical_care/core/helper/type_parser.dart';
import 'package:medical_care/features/home/model/home_model/latest_assessment.dart';
import 'package:medical_care/features/home/model/home_model/medical_advice.dart';

class HomeModel {
  LatestAssessment? latestAssessment;
  List<MedicalAdvice>? medicalAdvices;
  int? totalAssessments;

  HomeModel({
    this.latestAssessment,
    this.medicalAdvices,
    this.totalAssessments,
  });

  @override
  String toString() {
    return 'HomeModel(latestAssessment: $latestAssessment, medicalAdvices: $medicalAdvices, totalAssessments: $totalAssessments)';
  }

  factory HomeModel.fromMap(Map<String, dynamic> data) {
    final responseData = TypeParser.parseMap(data['data']);

    return HomeModel(
      latestAssessment: responseData?['latest_assessment'] == null || responseData?['latest_assessment'] is bool
          ? null
          : LatestAssessment.fromMap(
              responseData!['latest_assessment'] as Map<String, dynamic>,
            ),
      medicalAdvices: TypeParser.parseList<dynamic>(responseData?['medical_advices'])
          ?.map((e) => MedicalAdvice.fromMap(e as Map<String, dynamic>))
          .toList(),
      totalAssessments: TypeParser.parseInt(responseData?['total_assessments']),
    );
  }

  Map<String, dynamic> toMap() => {
    'latest_assessment': latestAssessment?.toMap(),
    'medical_advices': medicalAdvices?.map((e) => e.toMap()).toList(),
    'total_assessments': totalAssessments,
  };

  factory HomeModel.fromJson(String data) {
    return HomeModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  HomeModel copyWith({
    LatestAssessment? latestAssessment,
    List<MedicalAdvice>? medicalAdvices,
    int? totalAssessments,
  }) {
    return HomeModel(
      latestAssessment: latestAssessment ?? this.latestAssessment,
      medicalAdvices: medicalAdvices ?? this.medicalAdvices,
      totalAssessments: totalAssessments ?? this.totalAssessments,
    );
  }
}
