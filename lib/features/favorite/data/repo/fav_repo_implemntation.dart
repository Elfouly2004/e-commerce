
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mrcandy/features/Home/data/model/product_model.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/utils/endpoints.dart';
import '../../../carts/presentation/controller/carts_cubit.dart';
import '../../presentation/controller/fav_cubit.dart';
import '../model/fav_model.dart';
import 'fav_repo.dart';
import 'package:http/http.dart' as http;


class FavRepoImplemntation implements FavRepo {



  @override
  Future<Either<Failure, List<FavItemModel>>> getfav() async {
    List<FavItemModel> favlist = [];
    final token = Hive.box("setting").get("token");

    try {
      final response = await http.get(
        Uri.parse(EndPoints.baseUrl + EndPoints.favorites),
        headers: {
          "Authorization": "$token",
        },
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        print('Response body: $body');
        if (body["status"] == true) {
          favlist = [];

          if (body["data"]["data"] is List && body["data"]["data"].isNotEmpty) {
            for (var favoriteItem in body["data"]["data"]) {
              print("Item ID: ${favoriteItem["id"].toInt()}");
            }
          } else {
            print("No favorite items found.");
          }

          for (var item in body["data"]["data"]) {
            try {
              favlist.add(FavItemModel.fromJson(item));
            } catch (e) {
              print("Error processing product: $e");
            }
          }

          return right(favlist);
        } else {
          print("API response status is false");
          return left(ApiFailure(message: body["message"] ?? "Unknown error"));
        }
      }
 else {
        return left(ApiFailure(message: "Failed to fetch data, Status code: ${response.statusCode}"));
      }
    } on SocketException {
      return left(NoInternetFailure(message: "No Internet"));
    } catch (e) {
      print('Error occurred: $e');
      return left(ApiFailure(message: "Error Occurred"));
    }
  }

  Future<Either<Failure, void>> DeleteFav({context, required int index}) async {
    try {
      final token = Hive.box("setting").get("token");

      if (token == null || token.isEmpty) {
        return left(ApiFailure(message: "Authentication token is missing."));
      }

      final itemId = BlocProvider.of<FavoritesCubit>(context).favoritesList[index].id;

      print("🟢 Deleting item with ID: $itemId");
      print("🔑 Token is: $token");

      final response = await http.delete(
        Uri.parse("${EndPoints.baseUrl}${EndPoints.favorites}/$itemId"),
        headers: {
          "Authorization": "$token",
        },
      );

      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (responseBody["status"] == true) {

          return const Right(null);
        } else {
          return left(ApiFailure(message: responseBody["message"] ?? "Failed to delete item"));
        }
      } else {
        return left(ApiFailure(
            message: "Failed to delete, Status code: ${response.statusCode}"));
      }
    } on SocketException {
      return left(NoInternetFailure(message: "No Internet connection"));
    } catch (e) {
      print(' Error occurred: $e');
      return left(ApiFailure(message: "An unexpected error occurred"));
    }
  }



}




