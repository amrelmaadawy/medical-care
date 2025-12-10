import 'package:bloc/bloc.dart';
import 'package:medical_care/features/home/model/home_model/home_model.dart';
import 'package:medical_care/features/home/repo/home_api.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

Future<void> getHomeData() async {
  emit(GetHomeDataLoading());
  try {
    HomeModel homeModel = await HomeApi().getHomeData();
    print(homeModel.medicalAdvices?[0].title);
    emit(GetHomeDataSuccess(homeModel));
  } catch (e) {
    print(e.toString());
    emit(GetHomeDataError(e.toString()));
  }
}
}
