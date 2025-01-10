import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  int userid;
  String useruid;
  String firstname;
  String lastname;
  String nickname;
  String email;
  String profileicon;
  bool deleted;
  DateTime deletedat;
  DateTime createdat;
  DateTime lastactive;
  String telephonenumber;
  String telephoneprefix;
  int level;
  int experience;
  String settingsconfig;

  UserModel({
    required this.userid,
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
  })

  factory UserModel.fromJson(Map<String,dynamic> json) => _$UserModelFromJson(json);

  Map<String,dynamic> toJson() => _$UserModelFromJson(json);
}
