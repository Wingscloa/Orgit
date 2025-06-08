import 'dart:typed_data';
import 'dart:convert';

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

class UserProfileRequest {
  final String useruid;
  final String firstname;
  final String lastname;
  final String nickname;
  final String telephoneprefix;
  final String telephonenumber;
  final DateTime birthday;
  final Uint8List? profileicon;

  UserProfileRequest({
    required this.useruid,
    required this.firstname,
    required this.lastname,
    required this.nickname,
    required this.telephoneprefix,
    required this.telephonenumber,
    required this.birthday,
    this.profileicon,
  });
  Map<String, dynamic> toJson() {
    return {
      'useruid': useruid,
      'firstname': firstname,
      'lastname': lastname,
      'nickname': nickname,
      'telephoneprefix': telephoneprefix,
      'telephonenumber': telephonenumber,
      'birthday': birthday.toIso8601String(),
      if (profileicon != null) 'profileicon': base64Encode(profileicon!),
    };
  }

  // Validation methods
  bool isValid() {
    return firstname.isNotEmpty &&
        firstname.length <= 32 &&
        lastname.isNotEmpty &&
        lastname.length <= 32 &&
        nickname.length <= 32 &&
        telephoneprefix.length == 3 &&
        telephonenumber.length == 9;
  }

  String? validateFirstname() {
    if (firstname.isEmpty) return 'Jméno je povinné';
    if (firstname.length > 32) return 'Jméno může mít maximálně 32 znaků';
    return null;
  }

  String? validateLastname() {
    if (lastname.isEmpty) return 'Příjmení je povinné';
    if (lastname.length > 32) return 'Příjmení může mít maximálně 32 znaků';
    return null;
  }

  String? validateNickname() {
    if (nickname.length > 32) return 'Přezdívka může mít maximálně 32 znaků';
    return null;
  }

  String? validateTelephonePrefix() {
    if (telephoneprefix.length != 3) return 'Předvolba musí mít 3 znaky';
    return null;
  }

  String? validateTelephonenumber() {
    if (telephonenumber.length != 9) return 'Telefonní číslo musí mít 9 znaků';
    return null;
  }
}
