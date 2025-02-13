import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../model/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, ProfileModel>> getprofile();
}
