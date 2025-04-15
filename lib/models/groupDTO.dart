class GroupResponse{
    final Uri profilepicture;
    final String name;
    final String city;
    final String region;
    final int leader;
    final String description;
    final int createdby;
    final DateTime createdat;
    final bool deleted;

    GroupResponse({
        required this.profilepicture,
        required this.name,
        required this.city,
        required this.region,
        required this.leader,
        required this.description,
        required this.createdby,
        required this.createdat,
        required this.deleted
    });

    factory GroupResponse.fromJson(Map<String,dynamic> json) {
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
        deleted: json['deleted']
      );
    }
}