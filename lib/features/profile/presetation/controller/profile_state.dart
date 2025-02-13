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
