

import 'package:mrcandy/features/Greate_account/data/model/model.dart';

import '../../../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class GreateAccountRepo {

  Future<Either<Failure , UserModelToRegister>> Greate_account(
      {
        required UserModelToRegister userModelToRegister

      }
      ) ;

}