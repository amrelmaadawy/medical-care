part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetHomeDataLoading extends HomeState {}

class GetHomeDataSuccess extends HomeState {
  final HomeModel homeModel;
  GetHomeDataSuccess(this.homeModel);
}

class GetHomeDataError extends HomeState {
  final String errorMessage;
  GetHomeDataError(this.errorMessage);
}
