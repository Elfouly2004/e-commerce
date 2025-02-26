import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:mrcandy/features/Home/data/model/categories_model.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/endpoints.dart';
import '../../../../main.dart';
import '../../../carts/data/model/cart_model.dart';
import '../../presentation/controller/get_product/get_product_cubit.dart';
import '../model/banners_model.dart';
import '../model/product_model.dart';
import 'home_repo.dart';

class HomeRepoImplementation implements HomeRepo {


  List<ProductModel> productList = [];

  // String currentLang = EasyLocalization.of(navigatorKey.currentContext!)?.locale.languageCode ?? "ar";
  String get currentLang => EasyLocalization.of(navigatorKey.currentContext!)?.locale.languageCode ?? "ar";

  @override
  Future<Either<Failure, List<BannersModel>>> get_banners() async {
    List<BannersModel> banners = [];
    try {
      final response = await http.get(Uri.parse(EndPoints.baseUrl + EndPoints.banners));
      final body = jsonDecode(response.body);

      if (body["status"] == true) {
        for (var banner in body["data"]) {
          banners.add(BannersModel(
            urlImage: banner["image"],
            id: banner["id"],
            category: banner["category"],
            product: banner["product"],
          ));
        }
        return right(banners);
      } else {
        return left(ApiFailure(message: body["message"]));
      }
    } catch (e) {
      print('Error occurred: $e');
      return left(ApiFailure(message: "Error Occurred"));
    }
  }

  @override
  Future<Either<Failure, List<CategoriesModel>>> get_categories(BuildContext context) async{
    List<CategoriesModel> categoriesLst = [];
    try {

      final response = await http.get(
        Uri.parse(EndPoints.baseUrl + EndPoints.categories),
        headers: {
          "lang": currentLang,
        },
      );

      final body = jsonDecode(response.body);

      if (body["status"] == true) {
        for (var categorie in body["data"]["data"]) {
          categoriesLst.add(
            CategoriesModel(
              urlImage: categorie["image"],
              id: categorie["id"],
              name: categorie["name"],
            ),
          );
        }
        return right(categoriesLst);
      } else {
        return left(ApiFailure(message: body["message"]));
      }
    } on SocketException {
      return left(NoInternetFailure(message: "No Internet"));
    } catch (e) {
      print('Error occurred: $e');
      return left(ApiFailure(message: "Error Occurred"));
    }
  }


  @override
  Future<Either<Failure, List<ProductModel>>> get_product() async {
    try {

      final response = await http.get(
        Uri.parse(EndPoints.baseUrl + EndPoints.home),
        headers: {
          "lang": currentLang,
        },
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        print('Response data: ${body["data"]["data"]}');

        if (body["status"] == true) {
          List<ProductModel> productList = body["data"]["data"]
              .map<ProductModel>((product) => ProductModel.fromJson(product))
              .toList();
          return right(productList);
        } else {
          return left(ApiFailure(message: body["message"] ?? "Unknown error occurred"));
        }
      } else {
        return left(ApiFailure(message: "Failed to fetch data, Status code: ${response.statusCode}"));
      }
    } on SocketException {
      return left(NoInternetFailure(message: "No Internet"));
    } catch (e) {
      print('Error occurred: $e');
      return left(ApiFailure(message: "Error Occurred"));
    }
  }



  @override
  Future<Either<Failure, ProductModel>> Addfav({context, index}) async {
    print("Token is: ${Hive.box("setting").get("token")}");
    final token = Hive.box("setting").get("token");

    if (token == null || token.isEmpty) {
      print("Error: Token is missing or invalid");
      return left(ApiFailure(message: "Authentication token is missing."));
    }

    try {



      final Map<String, dynamic> body = {
        "product_id": BlocProvider.of<ProductsCubit>(context).productList[index].id.toString(),
      };

      final response = await http.post(
        Uri.parse(EndPoints.baseUrl + EndPoints.favorites),
        headers: {
          "Authorization": "$token",
          "lang": currentLang,
        },
        body: body,
      );

      print("Response: ${response.body}");
      print("Product ID: ${BlocProvider.of<ProductsCubit>(context).productList[index].id}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody["status"] == true) {
          final productData = responseBody["data"]["product"];
          final productModel = ProductModel.fromJson(productData);
          return right(productModel);
        } else {
          return left(ApiFailure(message: responseBody["message"] ?? "Failed to add to favorites"));
        }
      } else {
        return left(ApiFailure(message: "Failed to fetch data, Status code: ${response.statusCode}"));
      }
    } on SocketException {
      return left(NoInternetFailure(message: "No Internet"));
    } catch (e) {
      print('Error occurred: $e');
      return left(ApiFailure(message: "Error Occurred"));
    }
  }





  @override
  Future<Either<Failure, CartItemModel>> Add_carts({context, index}) async {
    print("Token is: ${Hive.box("setting").get("token")}");
    final token = Hive.box("setting").get("token");

    if (token == null || token.isEmpty) {
      print("Error: Token is missing or invalid");
      return left(ApiFailure(message: "Authentication token is missing."));
    }

    try {


      final Map<String, dynamic> body = {
        "product_id": BlocProvider.of<ProductsCubit>(context)
            .productList[index]
            .id
            .toString()
      };

      final response = await http.post(
        Uri.parse(EndPoints.baseUrl + EndPoints.carts),
        headers: {
          "Authorization": "$token",
          "lang": currentLang,


        },
        body: body,
      );

      print("Response: ${response.body}");
      print("Response: $currentLang");
      print("Response: $currentLang");
      print("Response: $currentLang");
      print("Response: $currentLang");
      print("Response: $currentLang");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (responseBody["status"] == true) {

          final cartItemData = responseBody["data"];
          final cartItemModel = CartItemModel.fromJson(cartItemData);
          return right(cartItemModel);
        } else {

          return left(ApiFailure(message: responseBody["message"] ?? "Failed to add to cart"));
        }
      } else {
        return left(ApiFailure(
            message: "Failed to fetch data, Status code: ${response.statusCode}"));
      }
    } on SocketException {
      return left(NoInternetFailure(message: "No Internet"));
    } catch (e) {
      print('Error occurred: $e');
      return left(ApiFailure(message: "Error Occurred"));
    }
  }


}
