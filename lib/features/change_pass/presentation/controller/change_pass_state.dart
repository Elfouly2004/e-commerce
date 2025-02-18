
abstract class ChangePassState {}

final class ChangePassInitial extends ChangePassState {}



class ChangePasswordLoading extends ChangePassState {}

class ChangePasswordSuccess extends ChangePassState {
  final String message;
  ChangePasswordSuccess({required this.message});
}

class ChangePasswordFailure extends ChangePassState {
  final String errorMessage;
  ChangePasswordFailure({required this.errorMessage});
}

