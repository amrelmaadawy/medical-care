import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:medical_care/core/helper/dio_helper.dart';
import 'package:medical_care/core/network/dio_client.dart';
import 'package:medical_care/features/home/model/home_model/home_model.dart';
import 'package:medical_care/features/home/model/symptom.dart';
import 'package:medical_care/features/home/repo/home_repo.dart';

class HomeApi extends HomeRepo {
  DioHelper dio = DioHelper();
  List<Symptom> symptoms = [];
  @override
  Future<HomeModel> getHomeData() async {
    var response = await dio.getData('https://graduation.coderaeg.com/api/');
    if (kDebugMode) {
      print(response.data);
    }

    return HomeModel.fromMap(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<Symptom>> getSymptoms() async {
    var response = await dio.getData(
      'https://graduation.coderaeg.com/api/symptoms/',
    );
     final List data = response.data['data'];
    symptoms = data.map<Symptom>((symptomData) {
      return Symptom.fromMap(symptomData as Map<String, dynamic>);
    }).toList();
    print(symptoms.length);
    return symptoms;
  }

  Future<Map<String, dynamic>> submitAiDiagnosis({
    required String imagePath,
    required String symptomsText,
    int? age,
    String? gender,
    int? durationDays,
  }) async {
    final formData = FormData.fromMap({
      if (age != null) "patient_age": age,
      if (gender != null) "patient_gender": gender,
      if (symptomsText.isNotEmpty) "symptoms": symptomsText,
      if (durationDays != null) "duration_days": durationDays,
    });

    formData.files.add(MapEntry(
      "image",
      await MultipartFile.fromFile(imagePath),
    ));

    final actualDio = DioClient().dio;
    final response = await actualDio.post(
      '/api/ai-diagnosis',
      data: formData,
    );

    return response.data as Map<String, dynamic>;
  }
}
