import 'package:medical_care/features/home/model/home_model/home_model.dart';
import 'package:medical_care/features/home/model/symptom.dart';

abstract class HomeRepo {
  Future<HomeModel> getHomeData();
  Future<List<Symptom>> getSymptoms();
  
}
