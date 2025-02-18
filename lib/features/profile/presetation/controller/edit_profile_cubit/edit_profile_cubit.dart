import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/errors/failure.dart';
import '../../../../settings/data/repo/setting_repo.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final SettingRepo editProfileRepo;

  EditProfileCubit({required this.editProfileRepo}) : super(EditProfileInitial());

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

  Future<void> editProfile({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String image,
  }) async {
    if (myPhoto == null) {
      emit(EditProfileFailure(error: "Please select an image first."));
      return;
    }

    File imageFile = File(myPhoto!.path);
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64String = base64Encode(imageBytes);

    emit(EditProfileLoading());

    final Either<Failure, String> result = await editProfileRepo.editprofile(
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
      },
    );
  }
}

