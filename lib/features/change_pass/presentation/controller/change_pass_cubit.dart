import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:mrcandy/core/errors/failure.dart';
import 'package:mrcandy/features/settings/data/repo/setting_repo.dart';

import 'change_pass_state.dart';




class ChangePassCubit extends Cubit<ChangePassState> {
  final SettingRepo settingRepo;

  ChangePassCubit({required this.settingRepo}) : super(ChangePassInitial());

  Future<void> changepass({required String currentPassword, required String newPassword}) async {
    emit(ChangePasswordLoading());

    final Either<Failure, String> result = await settingRepo.changepassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    result.fold(
          (failure) => emit(ChangePasswordFailure(errorMessage: failure.message)),
          (successMessage) => emit(ChangePasswordSuccess(message: successMessage)),
    );
  }
}