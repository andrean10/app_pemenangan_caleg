class RequestLoginModel {
  final String username;
  final String password;

  RequestLoginModel({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };

  @override
  String toString() =>
      'RequestLoginModel(username: $username, password: $password)';
}
