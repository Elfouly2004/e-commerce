part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final ProfileModel profile;
  ProfileSuccess(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ProfileFailure extends ProfileState {
  final String message;
  ProfileFailure(this.message);

  @override
  List<Object?> get props => [message];
}


class EditProfileLoading extends ProfileState {}
class EditProfileupdated extends ProfileState {}

class EditProfileSuccess extends ProfileState {
  final String message;
  EditProfileSuccess({required this.message});
}

class EditProfileFailure extends ProfileState {
  final String error;
  EditProfileFailure({required this.error});
}

class EditProfileImageUploaded extends ProfileState {
  final String imageUrl;

  EditProfileImageUploaded({required this.imageUrl});
}

