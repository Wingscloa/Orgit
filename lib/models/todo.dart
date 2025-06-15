class Todo {
  final int? todoId;
  final int userId;
  final String title;
  final String? note;
  final DateTime whenComplete;
  final DateTime? toComplete;
  final bool completed;
  final DateTime createdAt;
  final String music;

  Todo({
    this.todoId,
    required this.userId,
    required this.title,
    this.note,
    required this.whenComplete,
    this.toComplete,
    this.completed = false,
    required this.createdAt,
    this.music = 'joy',
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      todoId: json['todoid'],
      userId: json['userid'],
      title: json['title'],
      note: json['note'],
      whenComplete: DateTime.parse(json['whencomplete']),
      toComplete: json['tocomplete'] != null
          ? DateTime.parse(json['tocomplete'])
          : null,
      completed: json['completed'] ?? false,
      createdAt: DateTime.parse(json['createdat']),
      music: json['music'] ?? 'joy',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'todoid': todoId,
      'userid': userId,
      'title': title,
      'note': note,
      'whencomplete': whenComplete.toIso8601String(),
      'tocomplete': toComplete?.toIso8601String(),
      'completed': completed,
      'createdat': createdAt.toIso8601String(),
      'music': music,
    };
  }

  Todo copyWith({
    int? todoId,
    int? userId,
    String? title,
    String? note,
    DateTime? whenComplete,
    DateTime? toComplete,
    bool? completed,
    DateTime? createdAt,
    String? music,
  }) {
    return Todo(
      todoId: todoId ?? this.todoId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      note: note ?? this.note,
      whenComplete: whenComplete ?? this.whenComplete,
      toComplete: toComplete ?? this.toComplete,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
      music: music ?? this.music,
    );
  }
}
