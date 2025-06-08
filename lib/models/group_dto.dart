import 'dart:typed_data';
import 'dart:convert';

class GroupResponse {
  final Uri profilepicture;
  final String name;
  final String city;
  final String region;
  final int leader;
  final String description;
  final int createdby;
  final DateTime createdat;
  final bool deleted;

  GroupResponse(
      {required this.profilepicture,
      required this.name,
      required this.city,
      required this.region,
      required this.leader,
      required this.description,
      required this.createdby,
      required this.createdat,
      required this.deleted});

  factory GroupResponse.fromJson(Map<String, dynamic> json) {
    final profilepicture = json['profilepicture'];

    return GroupResponse(
        profilepicture: Uri.parse(profilepicture),
        name: json['name'],
        city: json['city'],
        region: json['region'],
        leader: json['leader'],
        description: json['description'],
        createdby: json['createdby'],
        createdat: DateTime.parse(json['createdat']),
        deleted: json['deleted']);
  }
}

class GroupCreateRequest {
  final Uint8List? profilepicture;
  final String name;
  final int city;
  final int region;
  final int leader;
  final String description;
  final int createdby;
  GroupCreateRequest({
    this.profilepicture,
    required this.name,
    required this.city,
    required this.region,
    required this.leader,
    required this.description,
    required this.createdby,
  });
  Map<String, dynamic> toJson() {
    return {
      'profilepicture':
          profilepicture != null ? base64Encode(profilepicture!) : '',
      'name': name,
      'city': city,
      'region': region,
      'leader': leader,
      'description': description,
      'createdby': createdby,
    };
  }

  factory GroupCreateRequest.fromJson(Map<String, dynamic> json) {
    return GroupCreateRequest(
      profilepicture: json['profilepicture'] != null
          ? base64Decode(json['profilepicture'])
          : null,
      name: json['name'],
      city: json['city'],
      region: json['region'],
      leader: json['leader'],
      description: json['description'],
      createdby: json['createdby'],
    );
  }
}

class GroupSearchResponse {
  final int groupid;
  final String name;
  final String profilepicture;
  final String city_name;

  GroupSearchResponse({
    required this.groupid,
    required this.name,
    required this.profilepicture,
    required this.city_name,
  });

  factory GroupSearchResponse.fromJson(Map<String, dynamic> json) {
    return GroupSearchResponse(
      groupid: json['groupid'],
      name: json['name'],
      profilepicture: json['profilepicture'],
      city_name: json['city_name'],
    );
  }
}
