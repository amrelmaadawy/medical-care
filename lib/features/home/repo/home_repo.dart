import 'package:medical_care/features/home/model/home_model/home_model.dart';

abstract class HomeRepo {
  Future<HomeModel> getHomeData();
}
