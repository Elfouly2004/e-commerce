import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<http.Response> post({
    required Map<String, dynamic> body,
    required String url,
    required String token,
    Map<String,String>?Headers,
  }) async {
    final encodedBody = body.entries.map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}').join('&');

    final response = await http.post(
      Uri.parse(url),
      headers:Headers?? {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token',
      },
      body: encodedBody,
    );

    return response;
  }
}
