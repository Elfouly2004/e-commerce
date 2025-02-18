import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert'; // لإضافة مكتبة dart:convert
import 'dart:io';

// استيراد الموديلات
import '../../data/model/model.dart';
import '../../data/repo/Greate_account_repo.dart'; // لإضافة مكتبة dart:io لقراءة ملفات الصور

part 'greate_account_state.dart';

class GreateAccountCubit extends Cubit<GreateAccountState> {
  GreateAccountCubit(this.greateAccountRepo) : super(GreateAccountInitial());

  // تعريف المتغيرات
  final TextEditingController Email = TextEditingController();
  final TextEditingController Name = TextEditingController();
  final TextEditingController Phone = TextEditingController();
  final TextEditingController password = TextEditingController();

  XFile? myPhoto;

  Future<XFile?> pickImage() async {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  choosephoto() {
    pickImage().then((value) {
      emit(GreateAccountphotoSuccess());
      myPhoto = value;
    });
  }

  final GreateAccountRepo greateAccountRepo;

  Future<void> Greateacoount(BuildContext context) async {
    emit(GreateAccountLoadingState());
    try {
      String? base64String;
      if (myPhoto != null) {
        File imageFile = File(myPhoto!.path);
        List<int> imageBytes = await imageFile.readAsBytes();
        base64String = base64Encode(imageBytes);
      }

      final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(Email.text.trim());

      if (!emailValid) {
        emit(GreateAccountFailureState(errorMessage: "Please enter a correct email."));
      } else if (Name.text.isEmpty) {
        emit(GreateAccountFailureState(errorMessage: "Name cannot be empty."));
      } else if (Phone.text.isEmpty) {
        emit(GreateAccountFailureState(errorMessage: "Phone number is required."));
      } else if (password.text.isEmpty) {
        emit(GreateAccountFailureState(errorMessage: "Password cannot be empty."));
      } else if (base64String == null) {
        emit(GreateAccountFailureState(errorMessage: "Please choose a photo."));
      } else {
        var result = await greateAccountRepo.Greate_account(
          userModelToRegister: UserModelToRegister(
            name: Name.text.trim(),
            email: Email.text.trim(),
            phone: Phone.text.trim(),
            image: base64String,
            password: password.text.trim(),
          ),
        );

        result.fold(
              (left) {
            emit(GreateAccountFailureState(errorMessage: left.message));
            print(left.message);
          },
              (right) async {

                emit(GreateAccountSuccessState(userModelToRegister: right));
          },
        );

      }
    } catch (e) {
      emit(GreateAccountFailureState(errorMessage: "An unexpected error occurred."));
    }
  }
}
