class SignUp {
  final String username;
  final String password;
  final String name;
  final String email;

  SignUp({required this.username, required this.password, required this.name, required this.email});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'name': name,
      'email': email,
    };
  }
}