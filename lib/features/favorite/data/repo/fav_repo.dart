import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:mrcandy/features/Home/data/model/product_model.dart';
import 'package:mrcandy/features/favorite/data/model/fav_model.dart';

import '../../../../core/errors/failure.dart';

abstract class FavRepo {

  Future<Either<Failure, List<FavItemModel>>> getfav();


  Future<Either<Failure, void>> DeleteFav({ context, required int index});
}
