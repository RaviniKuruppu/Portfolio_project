class UserCredentials {
  final String username;
  final String password;

  UserCredentials({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
