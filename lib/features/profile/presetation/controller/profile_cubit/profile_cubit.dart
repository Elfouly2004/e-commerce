import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mrcandy/core/errors/failure.dart';
import 'package:mrcandy/features/profile/data/model/profile_model.dart';
import 'package:mrcandy/features/settings/data/repo/setting_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final SettingRepo settingRepo;

  ProfileCubit({required this.settingRepo}) : super(ProfileInitial());

  XFile? myPhoto;
  String? uploadedImageUrl;

  Future<XFile?> pickImage() async {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  void choosephoto() {
    pickImage().then((value) {
      if (value != null) {
        myPhoto = value;
        uploadedImageUrl = myPhoto!.path;
        emit(EditProfileImageUploaded(imageUrl: uploadedImageUrl!));
      }
    });
  }


  Future<void> fetchProfile() async {
    emit(ProfileLoading());

    final Either<Failure, ProfileModel> result = await settingRepo.getprofile();

    result.fold(
          (failure) => emit(ProfileFailure(failure.message)),
          (profile) => emit(ProfileSuccess(profile)),
    );

  }





  Future<void> editProfile({required String name, required String email, required String password, required String phone, required String image,}) async {
    if (myPhoto == null) {
      emit(EditProfileFailure(error: "Please select an image first."));
      return;
    }

    File imageFile = File(myPhoto!.path);
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64String = base64Encode(imageBytes);

    emit(EditProfileLoading());

    final Either<Failure, String> result = await settingRepo.editprofile(
      name: name,
      email: email,
      password: password,
      phone: phone,
      image: base64String,
    );

    result.fold(
          (failure) => emit(EditProfileFailure(error: failure.message)),
          (newImageUrl) {
        uploadedImageUrl = newImageUrl;

        emit(EditProfileSuccess(message: "Profile updated successfully"));
        // fetchProfile();


      },



    );
  }






}
