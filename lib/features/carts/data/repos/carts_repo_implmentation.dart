
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:mrcandy/core/errors/failure.dart';

import 'package:mrcandy/features/carts/presentation/controller/carts_cubit.dart';

import '../../../../core/utils/endpoints.dart';
import '../model/cart_model.dart';
import 'carts_repo.dart';
import 'package:http/http.dart' as http;


class CartsRepoImplmentation implements CartsRepo {


int totalprice=0;
  @override
  Future<Either<Failure, List<CartItemModel>>> getCarts() async {
    List<CartItemModel> cartsList = [];
    final token = Hive.box("setting").get("token");

    try {
      final response = await http.get(
        Uri.parse(EndPoints.baseUrl + EndPoints.carts),
        headers: {
          "Authorization": "$token",
        },
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        totalprice=body["data"]["total"].toInt();
        print('Response body: $body');  // Log the entire response body
        if (body["status"] == true) {
          cartsList = [];
          for (var cartItem in body["data"]["cart_items"]) {
            try {
              cartsList.add(CartItemModel.fromJson(cartItem));
            } catch (e) {
              print("Error processing cart item: $e");
            }
          }
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
  Future<Either<Failure, List<CartItemModel>>> updateCarts({required int IDcart, required int quantity,}) async {
    List<CartItemModel> cartsList = [];
    final token = Hive.box("setting").get("token");

    try {
      final response = await http.put(
        Uri.parse("S{EndPoints.baseUrl + EndPoints.carts}/$IDcart"),
        headers: {
          "Authorization": "$token",
        },
        body: jsonEncode({
          "quantity": quantity, // إرسال البيانات في body
        }),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        totalprice=body["data"]["total"].toInt();
        print('Response body: $body');  // Log the entire response body
        if (body["status"] == true) {
          cartsList = [];
          for (var cartItem in body["data"]["cart_items"]) {
            try {
              cartsList.add(CartItemModel.fromJson(cartItem));
            } catch (e) {
              print("Error processing cart item: $e");
            }
          }
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
