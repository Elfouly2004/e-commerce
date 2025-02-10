import 'package:dartz/dartz.dart';
import 'package:mrcandy/features/Home/data/model/categories_model.dart';

import '../../../../core/errors/failure.dart';
import '../../../carts/data/model/cart_model.dart';
import '../model/banners_model.dart';
import '../model/product_model.dart';

abstract class HomeRepo {


  Future<Either<Failure,List<BannersModel>>> get_banners();


  Future<Either<Failure,List<CategoriesModel>>> get_categories();


  Future<Either<Failure,List<ProductModel>>> get_product();


  Future<Either<Failure,List<ProductModel>>> get_Gatgories();


  Future<Either<Failure, ProductModel>> Addfav();




  Future<Either<Failure, CartItemModel>> Add_carts();





}