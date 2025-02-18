part of 'edit_profile_cubit.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  final String message;
  EditProfileSuccess({required this.message});
}

class EditProfileFailure extends EditProfileState {
  final String error;
  EditProfileFailure({required this.error});
}

class EditProfileImageUploaded extends EditProfileState {
  final String imageUrl;

  EditProfileImageUploaded({required this.imageUrl});
}
