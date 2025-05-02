// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:logger/logger.dart';

class UserResponse {
  final int userid;
  final String useruid;
  final String firstname;
  final String lastname;
  final String nickname;
  final String email;
  final DateTime birthday;
  final bool verified;
  final bool deleted;
  final String telephonenumber;
  final String telephoneprefix;
  final int level;
  final int experience;
  final Uri profileicon;
  final DateTime? deletedat;
  final DateTime createdat;
  final DateTime? lastactive;

  UserResponse(
      {required this.userid,
      required this.useruid,
      required this.firstname,
      required this.lastname,
      required this.nickname,
      required this.email,
      required this.birthday,
      required this.verified,
      required this.deleted,
      required this.telephonenumber,
      required this.telephoneprefix,
      required this.level,
      required this.experience,
      required this.profileicon,
      required this.deletedat,
      required this.createdat,
      required this.lastactive});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    final profileicon = json['profileicon'];
    final deletedat =
        json['deletedat'] == null ? null : DateTime.parse(json['deletedat']);
    final lastactive =
        json['lastactive'] == null ? null : DateTime.parse(json['lastactive']);

    return UserResponse(
        userid: json['userid'],
        useruid: json['useruid'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        nickname: json['nickname'],
        email: json['email'],
        birthday: DateTime.parse(json['birthday']),
        verified: json['verified'],
        deleted: json['deleted'],
        telephonenumber: json['telephonenumber'],
        telephoneprefix: json['telephoneprefix'],
        level: json['level'],
        experience: json['experience'],
        profileicon: Uri.parse(profileicon),
        deletedat: deletedat,
        createdat: DateTime.parse(json['createdat']),
        lastactive: lastactive);
  }
}
