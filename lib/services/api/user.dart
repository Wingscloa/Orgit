import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:orgit/models/user_dto.dart';
import 'package:http/http.dart' as http;
import 'package:orgit/services/api/config.dart';

Future<List<UserResponse>> fetchUsers() async {
  final List<UserResponse> users = [];
  final header = API.requestHeaders;
  header['Authorization'] = "Bearer ${API.tempToken}";
  final uri = Uri.parse("${API.baseURL}/User");
  var logger = Logger();

  final response = await http.get(
    uri,
    headers: header,
  );

  if (response.statusCode == 200) {
    dynamic jsonUsers = jsonDecode(response.body);
    for (var user in jsonUsers) {
      try {
        logger.f(user);
        users.add(UserResponse.fromJson(user));
      } catch (e, stack) {
        logger.e('Fail while parsing user: $e', stackTrace: stack);
      }
    }
    return users;
  } else {
    throw Exception('Failed to load users');
  }
}
