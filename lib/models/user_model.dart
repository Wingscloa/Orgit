import 'package:json_annotation/json_annotation.dart';
import 'dart:typed_data';
import 'dart:convert';
part 'user_model.g.dart';

// Tento konvertor převede Uint8List na base64 a zpět
class Uint8ListConverter implements JsonConverter<Uint8List?, String?> {
  const Uint8ListConverter();

  @override
  Uint8List? fromJson(String? json) {
    if (json == null) return null;
    return base64Decode(json); // Dekóduje base64 do Uint8List
  }

  @override
  String? toJson(Uint8List? object) {
    if (object == null) return null;
    return base64Encode(object); // Převede Uint8List na base64
  }
}

@JsonSerializable()
class UserModel {
  final int userid;
  final String useruid;
  final DateTime createdat;
  final bool verified;
  final String firstname;
  final String lastname;
  final DateTime lastactive;
  final bool onnotify;
  final String nickname;
  final String telephoneprefix;
  final String telephonenumber;
  final String email;
  final int level;
  @Uint8ListConverter()
  final Uint8List? profileicon;
  final int experience;
  final bool deleted;
  @Uint8ListConverter()
  final Uint8List? settingsconfig;
  final DateTime? deletedat;
  final DateTime birthday;

  UserModel(
      {required this.userid,
      required this.useruid,
      required this.firstname,
      required this.lastname,
      required this.nickname,
      required this.email,
      required this.profileicon,
      required this.deleted,
      required this.deletedat,
      required this.createdat,
      required this.lastactive,
      required this.telephonenumber,
      required this.telephoneprefix,
      required this.level,
      required this.experience,
      required this.settingsconfig,
      required this.birthday,
      required this.verified,
      required this.onnotify});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class ApiResponseUser {
  final int status_code;
  final UserModel detail;
  final dynamic headers;

  ApiResponseUser(
      {required this.status_code, required this.detail, required this.headers});

  factory ApiResponseUser.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseUserFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseUserToJson(this);
}

@JsonSerializable()
class ApiResponseUsers {
  final int status_code;
  final List<UserModel> detail;
  final dynamic headers;

  ApiResponseUsers(
      {required this.status_code, required this.detail, required this.headers});

  factory ApiResponseUsers.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseUsersFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseUsersToJson(this);
}

@JsonSerializable()
class userAddSchema {
  final String useruid;
  final String firstname;
  final String lastname;
  final String nickname;
  final String email;
  @Uint8ListConverter()
  final Uint8List? profileicon;
  final String telephoneprefix;
  final String telephonenumber;
  final DateTime lastactive;
  final DateTime birthday;

  userAddSchema(
      {required this.useruid,
      required this.firstname,
      required this.lastname,
      required this.nickname,
      required this.email,
      required this.profileicon,
      required this.telephoneprefix,
      required this.telephonenumber,
      required this.lastactive,
      required this.birthday});

  factory userAddSchema.fromJson(Map<String, dynamic> json) =>
      _$userAddSchemaFromJson(json);

  Map<String, dynamic> toJson() => _$userAddSchemaToJson(this);
}

@JsonSerializable()
class userCreateProfile {
  final String useruid;
  final String firstname;
  final String lastname;
  final String nickname;
  @Uint8ListConverter()
  final Uint8List? profileicon;
  final String telephoneprefix;
  final String telephonenumber;
  final DateTime birthday;

  userCreateProfile(
      {required this.useruid,
      required this.firstname,
      required this.lastname,
      required this.nickname,
      required this.profileicon,
      required this.telephonenumber,
      required this.telephoneprefix,
      required this.birthday});

  factory userCreateProfile.fromJson(Map<String, dynamic> json) =>
      _$userCreateProfileFromJson(json);

  Map<String, dynamic> toJson() => _$userCreateProfileToJson(this);
}
