import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mrcandy/core/errors/failure.dart';
import 'package:mrcandy/core/token/token.dart';
import 'package:mrcandy/features/profile/data/model/profile_model.dart';
import 'package:mrcandy/features/settings/data/repo/setting_repo.dart';
import '../../../../core/utils/endpoints.dart';
import 'package:http/http.dart' as http;

class SettingRepoImplemntation implements SettingRepo {
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

@override
  Future<Either<Failure, String>> changepassword({required String currentPassword, required String newPassword,}) async {
    try {
      final token = AuthHelper.getToken();

      if (token == null || token.isEmpty) {
        debugPrint("Error: Token is missing or invalid");
        return left(ApiFailure(message: "Authentication token is missing."));
      }

      debugPrint("Changing password with token: $token");

      final response = await http.post(
        Uri.parse(EndPoints.baseUrl + EndPoints.changepassword),
        headers: {
          "Authorization": token,
          "Accept": "application/json",
        },
        body: {
          "current_password": currentPassword,
          "new_password": newPassword,
        },
      );

      debugPrint("Response Status: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return right(responseBody["message"] ?? "Password changed successfully");
      } else if (response.statusCode == 401) {
        AuthHelper.removeToken();
        return left(ApiFailure(message: "Unauthorized: Please login again."));
      } else {
        return left(ApiFailure(message: responseBody["message"] ?? "Failed to change password"));
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




  @override
  Future<Either<Failure, String>> editprofile(
      {required String name, required  String email,
        required String password , required String phone,
        required String image})
  async {
    try {
      final token = AuthHelper.getToken();

      if (token == null || token.isEmpty) {
        debugPrint("Error: Token is missing or invalid");
        return left(ApiFailure(message: "Authentication token is missing."));
      }

      debugPrint("Changing password with token: $token");

      final response = await http.put(
        Uri.parse(EndPoints.baseUrl + EndPoints.updateprofile),
        headers: {
          "Authorization": token,
          "Accept": "application/json",
        },
        body: {
          "name": name,
          "phone": phone,
          "email": email,
          "password": password,
          "image":image
        },
      );

      debugPrint("Response Status: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return right(responseBody["message"] ?? "Edit profile successfully");
      } else if (response.statusCode == 401) {
        AuthHelper.removeToken();
        return left(ApiFailure(message: "Unauthorized: Please edit again."));
      } else {
        return left(ApiFailure(message: responseBody["message"] ?? "Failed to Edit profile"));
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

