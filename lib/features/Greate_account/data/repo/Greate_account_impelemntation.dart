import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:mrcandy/core/errors/failure.dart';
import '../../../../core/utils/endpoints.dart';
import 'package:http/http.dart' as http;
import '../model/model.dart';
import 'Greate_account_repo.dart';

class GreateAccountImplementation implements GreateAccountRepo {
  @override
  Future<Either<Failure, UserModelToRegister>> Greate_account({
    required UserModelToRegister userModelToRegister,
  }) async {
    try {
      final uri = Uri.parse(EndPoints.baseUrl + EndPoints.regisrer);

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userModelToRegister.toJson()),
      );

      final Map<String, dynamic> body = jsonDecode(response.body);

      if (body["status"] == true) {

        return right(userModelToRegister);
      } else {
        return left(ApiFailure(message: body["message"] ?? "Unknown error"));
      }
    } on SocketException {
      return left(NoInternetFailure(message: "No Internet connection"));
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }
}