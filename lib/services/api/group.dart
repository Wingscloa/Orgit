import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:orgit/models/group_dto.dart';
import 'package:http/http.dart' as http;
import 'package:orgit/services/api/config.dart';

Future<List<GroupResponse>> fetchGroups() async {
  final List<GroupResponse> groups = [];
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
    for (var group in jsonGroups) {
      try {
        groups.add(GroupResponse.fromJson(group));
        logger.f(groups.last.name);
      } catch (e, stack) {
        logger.e('Fail while parsing Group: $e', stackTrace: stack);
      }
    }
    return groups;
  } else {
    throw Exception('Failed to load Groups');
  }
}
