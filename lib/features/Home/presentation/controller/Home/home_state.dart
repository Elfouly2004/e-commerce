abstract class HomeState {}

class HomeInitialState extends HomeState {}
class updatefavoriteicon extends HomeState {}
class LoadingState extends HomeState {}
class SuccessState extends HomeState {}
class FailureState extends HomeState {
  final String errorMessage;
  FailureState({required this.errorMessage});
}
class NoInternetState extends HomeState {}

