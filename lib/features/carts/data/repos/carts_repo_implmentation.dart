
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:mrcandy/core/errors/failure.dart';

import 'package:mrcandy/features/carts/presentation/controller/carts_cubit.dart';

import '../../../../core/utils/endpoints.dart';
import '../../../../main.dart';
import '../model/cart_model.dart';
import 'carts_repo.dart';
import 'package:http/http.dart' as http;


class CartsRepoImplmentation implements CartsRepo {

  String get currentLang => EasyLocalization.of(navigatorKey.currentContext!)?.locale.languageCode ?? "ar";


int totalprice=0;
  @override
  Future<Either<Failure, List<CartItemModel>>> getCarts() async {
    final token = Hive.box("setting").get("token");

    try {
      final response = await http.get(
        Uri.parse(EndPoints.baseUrl + EndPoints.carts),
        headers: {
          "Authorization": "$token",
          "lang":currentLang,
        },
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        totalprice=body["data"]["total"].toInt();
        print('Response body: $body');
        if (body["status"] == true) {


          List<CartItemModel> cartsList = body["data"]["cart_items"]
              .map<CartItemModel>((product) => CartItemModel.fromJson(product))
              .toList();

          return right(cartsList);
        } else {
          return left(ApiFailure(message: body["message"] ?? "Unknown error"));
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
  Future<Either<Failure, List<CartItemModel>>> updateCarts({
    required int IDcart,
    required int quantity,
  }) async {
    final token = Hive.box("setting").get("token");

    try {
      final response = await http.put(
        Uri.parse("${EndPoints.baseUrl + EndPoints.carts}/${IDcart}"),
        headers: {
          "Authorization": "$token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "quantity": quantity.toInt(),
        }),
      );

      print("Updating cart with ID: $IDcart, Quantity: $quantity");

      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body["status"] != true) {
          return left(ApiFailure(message: body["message"] ?? "Unknown error"));
        }

        totalprice = body["data"]["total"]?.toInt() ?? 0;

        final List<CartItemModel> cartItems = [];

        if (body["data"].containsKey("cart_items") && body["data"]["cart_items"] != null) {
          final List<dynamic> cartItemsJson = body["data"]["cart_items"];
          cartItems.addAll(cartItemsJson.map((e) => CartItemModel.fromJson(e)));
        } else {
          print("Warning: 'cart_items' not found in response");
        }


        return right(cartItems);
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


  @override


  Future<Either<Failure, CartItemModel>> DeleteCarts({context, index}) async {
    print("Token is: ${Hive.box("setting").get("token")}");
    final token = Hive.box("setting").get("token");

    if (token == null || token.isEmpty) {
      return left(ApiFailure(message: "Authentication token is missing."));
    }

    try {
      final response = await http.delete(
        Uri.parse("${EndPoints.baseUrl + EndPoints.carts}/${BlocProvider.of<CartsCubit>(context).cartsList[index].id.toString()}"),
        headers: {
          "Authorization": "$token",
        },
      );

      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (responseBody["status"] == true) {
          // طلب ناجح
          final cartItemData = responseBody["data"];
          final cartItemModel = CartItemModel.fromJson(cartItemData);
          return right(cartItemModel);
        } else {
          // فشل بسبب خطأ في الطلب
          return left(ApiFailure(message: responseBody["message"] ?? "Failed to delete from cart"));
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
