import 'package:dartz/dartz.dart';
import 'package:mrcandy/features/favorite/data/model/fav_model.dart';

import '../../../../core/errors/failure.dart';

abstract class FavRepo {

  Future<Either<Failure, List<FavItemModel>>> getfav();


  Future<Either<Failure, void>> DeleteFav({ context, required int index});
}
