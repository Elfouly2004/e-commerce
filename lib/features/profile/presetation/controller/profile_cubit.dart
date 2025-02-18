import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mrcandy/core/errors/failure.dart';
import 'package:mrcandy/features/profile/data/model/profile_model.dart';
import 'package:mrcandy/features/settings/data/repo/setting_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final SettingRepo settingRepo;

  ProfileCubit({required this.settingRepo}) : super(ProfileInitial());

  Future<void> fetchProfile() async {
    emit(ProfileLoading());

    final Either<Failure, ProfileModel> result = await settingRepo.getprofile();

    result.fold(
          (failure) => emit(ProfileFailure(failure.message)),
          (profile) => emit(ProfileSuccess(profile)),
    );
  }
}
