import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:medical_care/features/home/model/home_model/home_model.dart';
import 'package:medical_care/features/home/repo/home_api.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getHomeData() async {
    emit(GetHomeDataLoading());
    try {
      HomeModel homeModel = await HomeApi().getHomeData();
      emit(GetHomeDataSuccess(homeModel));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      emit(GetHomeDataError(e.toString()));
    }
  }
}
