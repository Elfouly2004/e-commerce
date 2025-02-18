import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../profile/data/model/profile_model.dart';

abstract class SettingRepo {
  Future<Either<Failure, ProfileModel>> getprofile();

  Future<Either<Failure, String>> changepassword({required String currentPassword, required String newPassword});



  Future<Either<Failure, String>> editprofile(
      {required String name, required  String email,
        required String password , required String phone,required String image});





}
