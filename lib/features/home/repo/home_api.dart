import 'package:flutter/foundation.dart';
import 'package:medical_care/core/helper/dio_helper.dart';
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
}
