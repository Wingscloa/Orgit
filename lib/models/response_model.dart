import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable()
class boolResponse {
  final int status_code;
  final bool detail;
  final dynamic headers;

  boolResponse(
      {required this.status_code, required this.detail, required this.headers});

  factory boolResponse.fromJson(Map<String, dynamic> json) =>
      _$boolResponseFromJson(json);

  Map<String, dynamic> toJson() => _$boolResponseToJson(this);
}

@JsonSerializable()
class defaultResponse {
  final int status_code;
  final String detail;
  final dynamic headers;

  defaultResponse(
      {required this.status_code, required this.detail, required this.headers});

  factory defaultResponse.fromJson(Map<String, dynamic> json) =>
      _$defaultResponseFromJson(json);
  Map<String, dynamic> toJson() => _$defaultResponseToJson(this);
}
