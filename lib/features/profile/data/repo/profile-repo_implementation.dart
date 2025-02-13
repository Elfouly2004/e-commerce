import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mrcandy/core/errors/failure.dart';
import 'package:mrcandy/core/token/token.dart';
import 'package:mrcandy/features/profile/data/model/profile_model.dart';
import 'package:mrcandy/features/profile/data/repo/profile_repo.dart';
import '../../../../core/utils/endpoints.dart';
import 'package:http/http.dart' as http;

class ProfileRepoImplementation implements ProfileRepo {
  @override
  Future<Either<Failure, ProfileModel>> getprofile() async {
    try {
      final token = AuthHelper.getToken();

      if (token == null || token.isEmpty) {
        debugPrint("Error: Token is missing or invalid");
        return left(ApiFailure(message: "Authentication token is missing."));
      }

      debugPrint("Fetching profile with token: $token");

      final response = await http.get(
        Uri.parse(EndPoints.baseUrl + EndPoints.profile),
        headers: {
          "Authorization": token,
          "Accept": "application/json",
        },
      );

      debugPrint("Response Status: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (responseBody["status"] == true) {
          final profileModel = ProfileModel.fromJson(responseBody["data"]);

          // تحديث التوكن إذا تغير
          if (responseBody["data"]["token"] != token) {
            AuthHelper.saveToken(responseBody["data"]["token"]);
            debugPrint("Token updated in Hive");
          }

          return right(profileModel);
        } else {
          return left(ApiFailure(message: responseBody["message"] ?? "Failed to fetch profile"));
        }
      } else if (response.statusCode == 401) {
        AuthHelper.removeToken();
        return left(ApiFailure(message: "Unauthorized: Please login again."));
      } else {
        return left(ApiFailure(message: "Failed to fetch data, Status code: ${response.statusCode}"));
      }
    } on SocketException {
      return left(NoInternetFailure(message: "No Internet Connection"));
    } on FormatException {
      return left(ApiFailure(message: "Invalid response format"));
    } catch (e) {
      debugPrint('Error occurred: $e');
      return left(ApiFailure(message: "An unexpected error occurred"));
    }
  }
}
