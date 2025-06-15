class EventDto {
  final int? groupId;
  final int creator;
  final String name;
  final String color;
  final String description;
  final String address;
  final DateTime begins;
  final DateTime ends;
  final DateTime createdAt;
  final int? iconId;
  EventDto({
    this.groupId,
    required this.creator,
    required this.name,
    this.color = 'FFCB69',
    required this.description,
    required this.address,
    required this.begins,
    required this.ends,
    required this.createdAt,
    this.iconId,
  });

  factory EventDto.fromJson(Map<String, dynamic> json) {
    return EventDto(
      groupId: json['groupId'],
      creator: json['creator'],
      name: json['name'],
      color: json['color'] ?? 'FFCB69',
      description: json['description'],
      address: json['address'],
      begins: DateTime.parse(json['begins']),
      ends: DateTime.parse(json['ends']),
      createdAt: DateTime.parse(json['createdAt']),
      iconId: json['iconId'],
    );
  }

  /// Převede instanci EventDto na JSON objekt
  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'creator': creator,
      'name': name,
      'color': color,
      'description': description,
      'address': address,
      'begins': begins.toIso8601String(),
      'ends': ends.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'iconId': iconId,
    };
  }
}
