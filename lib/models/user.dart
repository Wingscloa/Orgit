class UserRegister {
  String useruid;
  String email;
  UserRegister({
    required this.useruid,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'useruid': useruid,
      'email': email,
    };
  }
}
