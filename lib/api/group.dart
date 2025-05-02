import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:orgit/models/group_dto.dart';
import 'package:http/http.dart' as http;
import 'package:orgit/api/config.dart';

Future<List<GroupResponse>> fetchGroups() async {
  final List<GroupResponse> Groups = [];
  final header = API.requestHeaders;
  header['Authorization'] = "Bearer ${API.tempToken}";
  final uri = Uri.parse("${API.baseURL}/Group");
  var logger = Logger();

  final response = await http.get(
    uri,
    headers: header,
  );

  if (response.statusCode == 200) {
    dynamic jsonGroups = jsonDecode(response.body);
    for (var Group in jsonGroups) {
      try {
        Groups.add(GroupResponse.fromJson(Group));
        logger.f(Groups.last.name);
      } catch (e, stack) {
        logger.e('Fail while parsing Group: $e', stackTrace: stack);
      }
    }
    return Groups;
  } else {
    throw Exception('Failed to load Groups');
  }
}
