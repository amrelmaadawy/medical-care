import 'package:flutter/foundation.dart';
import 'package:medical_care/core/helper/dio_helper.dart';
import 'package:medical_care/features/home/model/home_model/home_model.dart';
import 'package:medical_care/features/home/repo/home_repo.dart';

class HomeApi extends HomeRepo {
  DioHelper dio = DioHelper();

  @override
  Future<HomeModel> getHomeData() async {
    var response = await dio.getData('https://graduation.coderaeg.com/api/');
    if (kDebugMode) {
      print(response.data);
    }

    return HomeModel.fromMap(response.data as Map<String, dynamic>);
  }
}
