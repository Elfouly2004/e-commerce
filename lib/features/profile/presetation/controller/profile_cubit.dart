import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mrcandy/core/errors/failure.dart';
import 'package:mrcandy/features/profile/data/model/profile_model.dart';
import 'package:mrcandy/features/profile/data/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());

  Future<void> fetchProfile() async {
    emit(ProfileLoading());

    final Either<Failure, ProfileModel> result = await profileRepo.getprofile();

    result.fold(
          (failure) => emit(ProfileFailure(failure.message)),
          (profile) => emit(ProfileSuccess(profile)),
    );
  }
}
